import { initializeApp, cert, getApps } from "npm:firebase-admin@13.4.0/app";
import { getFirestore } from "npm:firebase-admin@13.4.0/firestore";
const FIREBASE_SERVICE_ACCOUNT =
  Deno.env.get("FIREBASE_SERVICE_ACCOUNT");

const PAYMOB_SECRET_KEY =
  Deno.env.get("PAYMOB_SECRET_KEY");

const PAYMOB_PUBLIC_KEY =
  Deno.env.get("PAYMOB_PUBLIC_KEY");

const PAYMOB_INTEGRATION_ID =
  Deno.env.get("PAYMOB_INTEGRATION_ID");

if (!FIREBASE_SERVICE_ACCOUNT) {
  throw new Error(
    "FIREBASE_SERVICE_ACCOUNT is missing",
  );
}

if (!PAYMOB_SECRET_KEY) {
  throw new Error(
    "PAYMOB_SECRET_KEY is missing",
  );
}

if (!PAYMOB_PUBLIC_KEY) {
  throw new Error(
    "PAYMOB_PUBLIC_KEY is missing",
  );
}

if (!PAYMOB_INTEGRATION_ID) {
  throw new Error(
    "PAYMOB_INTEGRATION_ID is missing",
  );
}

if (!getApps().length) {
  initializeApp({
    credential: cert(
      JSON.parse(
        FIREBASE_SERVICE_ACCOUNT,
      ),
    ),
  });
}

const db = getFirestore();

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods":
    "POST, OPTIONS",
};

function response(
  data: Record<string, unknown>,
  status = 200,
) {
  return new Response(
    JSON.stringify(data),
    {
      status,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json",
      },
    },
  );
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  if (req.method !== "POST") {
    return response(
      {
        success: false,
        message: "POST only",
      },
      405,
    );
  }

  try {
    // ==========================================
    // 1. Get orderId
    // ==========================================

    const body = await req.json();

    const orderId = body?.orderId;

    if (
      typeof orderId !== "string" ||
      orderId.trim().length === 0
    ) {
      return response(
        {
          success: false,
          message: "orderId is required",
        },
        400,
      );
    }

    // ==========================================
    // 2. Get Firestore order
    // ==========================================

    const orderRef = db
      .collection("orders")
      .doc(orderId);

    const orderSnapshot =
      await orderRef.get();

    if (!orderSnapshot.exists) {
      return response(
        {
          success: false,
          message: "Order not found",
        },
        404,
      );
    }

    const order =
      orderSnapshot.data();

    // ==========================================
    // 3. Validate order
    // ==========================================

    if (
      order?.paymentMethod !== "card"
    ) {
      return response(
        {
          success: false,
          message:
            "This order is not a card payment order",
        },
        400,
      );
    }

    if (
      order?.paymentStatus === "paid"
    ) {
      return response(
        {
          success: false,
          message: "Order is already paid",
        },
        400,
      );
    }

    // ==========================================
    // 4. Calculate amount
    // ==========================================

    const totalPrice =
      Number(order?.totalPrice);

    if (
      !Number.isFinite(totalPrice) ||
      totalPrice <= 0
    ) {
      return response(
        {
          success: false,
          message: "Invalid order total",
        },
        400,
      );
    }

    const amountCents =
      Math.round(totalPrice * 100);

    // ==========================================
    // 5. Shipping data
    // ==========================================

    const shipping =
      order?.shipping ?? {};

    const fullName =
      shipping.name
        ?.toString()
        .trim() ||
      "Customer";

    const nameParts =
      fullName.split(/\s+/);

    const firstName =
      nameParts.shift() ||
      "Customer";

    const lastName =
      nameParts.join(" ") ||
      "Customer";

    // ==========================================
    // 6. Create Paymob Intention
    // ==========================================

    const intentionBody = {
      amount: amountCents,

      currency: "EGP",

      payment_methods: [
        Number(
          PAYMOB_INTEGRATION_ID,
        ),
      ],

      items: [],

      billing_data: {
        apartment: "NA",

        email:
          shipping.email ||
          "customer@example.com",

        floor: "NA",

        first_name:
          firstName,

        last_name:
          lastName,

        street:
          shipping.address ||
          "NA",

        building: "NA",

        phone_number:
          shipping.phone ||
          "NA",

        shipping_method:
          "PKG",

        postal_code:
          "NA",

        city:
          shipping.city ||
          "Cairo",

        country:
          "EG",

        state:
          shipping.city ||
          "Cairo",
      },

      customer: {
        first_name:
          firstName,

        last_name:
          lastName,

        email:
          shipping.email ||
          "customer@example.com",

        phone_number:
          shipping.phone ||
          "NA",
      },

      special_reference:
        orderId,
    };

    console.log(
      "Creating Paymob intention",
      {
        orderId,
        amountCents,
        integrationId:
          PAYMOB_INTEGRATION_ID,
      },
    );

    const paymobResponse =
      await fetch(
        "https://accept.paymob.com/v1/intention/",
        {
          method: "POST",

          headers: {
            "Content-Type":
              "application/json",

            Authorization:
              `Token ${PAYMOB_SECRET_KEY}`,
          },

          body: JSON.stringify(
            intentionBody,
          ),
        },
      );

    const paymobText =
      await paymobResponse.text();

    let paymobData: any;

    try {
      paymobData =
        JSON.parse(
          paymobText,
        );
    } catch {
      paymobData = null;
    }

    console.log(
      "Paymob status:",
      paymobResponse.status,
    );

    if (!paymobResponse.ok) {
      console.error(
        "Paymob error:",
        paymobData ??
          paymobText,
      );

      return response(
        {
          success: false,
          message:
            "Paymob intention creation failed",
          details:
            paymobData ??
            paymobText,
        },
        500,
      );
    }

    // ==========================================
    // 7. Get client secret
    // ==========================================

    const clientSecret =
      paymobData?.client_secret;

    if (
      !clientSecret
    ) {
      console.error(
        "No client_secret:",
        paymobData,
      );

      return response(
        {
          success: false,
          message:
            "Paymob client secret was not returned",
        },
        500,
      );
    }

    // ==========================================
    // 8. Save Paymob references
    // ==========================================

    await orderRef.update({
      "payment.intentionId":
        paymobData?.id
          ? String(
              paymobData.id,
            )
          : null,

      "payment.paymobOrderId":
        paymobData?.intention_order_id
          ? String(
              paymobData.intention_order_id,
            )
          : null,

      paymentStatus:
        "awaiting_payment",

      orderStatus:
        "awaiting_payment",

      updatedAt:
        new Date().toISOString(),
    });

    // ==========================================
    // 9. Unified Checkout URL
    // ==========================================

    const paymentUrl =
      "https://accept.paymob.com/unifiedcheckout/" +
      `?publicKey=${encodeURIComponent(
        PAYMOB_PUBLIC_KEY,
      )}` +
      `&clientSecret=${encodeURIComponent(
        clientSecret,
      )}`;

    // ==========================================
    // 10. Return URL to Flutter
    // ==========================================

    return response({
      success: true,

      paymentUrl,

      intentionId:
        paymobData?.id
          ? String(
              paymobData.id,
            )
          : null,

      paymobOrderId:
        paymobData?.intention_order_id
          ? String(
              paymobData.intention_order_id,
            )
          : null,
    });
  } catch (error) {
    console.error(
      "CREATE PAYMOB PAYMENT ERROR:",
      error,
    );

    return response(
      {
        success: false,

        message:
          error instanceof Error
            ? error.message
            : "Payment creation failed",
      },
      500,
    );
  }
});