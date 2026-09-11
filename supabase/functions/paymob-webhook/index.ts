import { initializeApp, cert, getApps } from "npm:firebase-admin@13.4.0/app";
import { getFirestore } from "npm:firebase-admin@13.4.0/firestore";
const FIREBASE_SERVICE_ACCOUNT =
  Deno.env.get(
    "FIREBASE_SERVICE_ACCOUNT",
  );

const PAYMOB_HMAC_SECRET =
  Deno.env.get(
    "PAYMOB_HMAC_SECRET",
  );

if (!FIREBASE_SERVICE_ACCOUNT) {
  throw new Error(
    "FIREBASE_SERVICE_ACCOUNT is missing",
  );
}

if (!PAYMOB_HMAC_SECRET) {
  throw new Error(
    "PAYMOB_HMAC_SECRET is missing",
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

const db =
  getFirestore();

const corsHeaders = {
  "Access-Control-Allow-Origin":
    "*",

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
        "Content-Type":
          "application/json",
      },
    },
  );
}

async function calculateHmac(
  payment: any,
): Promise<string> {
  const values = [
    payment.amount_cents,
    payment.created_at,
    payment.currency,
    payment.error_occured,
    payment.has_parent_transaction,
    payment.id,
    payment.integration_id,
    payment.is_3d_secure,
    payment.is_auth,
    payment.is_capture,
    payment.is_refunded,
    payment.is_standalone_payment,
    payment.is_voided,
    payment.order?.id,
    payment.owner,
    payment.pending,
    payment.source_data?.pan,
    payment.source_data?.sub_type,
    payment.source_data?.type,
    payment.success,
  ];

  const hmacString =
    values
      .map((value) =>
        String(value),
      )
      .join("");

  const key =
    await crypto.subtle.importKey(
      "raw",

      new TextEncoder().encode(
        PAYMOB_HMAC_SECRET,
      ),

      {
        name: "HMAC",
        hash: "SHA-512",
      },

      false,

      ["sign"],
    );

  const signature =
    await crypto.subtle.sign(
      "HMAC",
      key,
      new TextEncoder().encode(
        hmacString,
      ),
    );

  return Array.from(
    new Uint8Array(
      signature,
    ),
  )
    .map((byte) =>
      byte
        .toString(16)
        .padStart(2, "0"),
    )
    .join("");
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(
      "ok",
      {
        headers:
          corsHeaders,
      },
    );
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
    console.log(
      "========== PAYMOB WEBHOOK ==========",
    );

    // ==========================================
    // 1. Read callback
    // ==========================================

    const body =
      await req.json();

    const payment =
      body?.obj;

    if (!payment) {
      return response({
        success: true,
      });
    }

    // ==========================================
    // 2. HMAC
    // ==========================================

    const receivedHmac =
      new URL(req.url)
        .searchParams
        .get("hmac");

    if (!receivedHmac) {
      return response(
        {
          success: false,
          message:
            "HMAC is missing",
        },
        401,
      );
    }

    const calculatedHmac =
      await calculateHmac(
        payment,
      );

    if (
      calculatedHmac.toLowerCase() !==
      receivedHmac.toLowerCase()
    ) {
      console.error(
        "INVALID HMAC",
      );

      return response(
        {
          success: false,
          message:
            "Invalid HMAC",
        },
        401,
      );
    }

    console.log(
      "HMAC VERIFIED",
    );

    // ==========================================
    // 3. Payment status
    // ==========================================

    if (
      payment.success !== true ||
      payment.pending === true ||
      payment.error_occured === true ||
      payment.is_voided === true ||
      payment.is_refunded === true
    ) {
      console.log(
        "PAYMENT NOT SUCCESSFUL",
      );

      return response({
        success: true,
      });
    }

    // ==========================================
    // 4. IDs
    // ==========================================

    const transactionId =
      payment.id;

    const paymobOrderId =
      payment.order?.id;

    if (!transactionId) {
      throw new Error(
        "Transaction ID missing",
      );
    }

    if (!paymobOrderId) {
      throw new Error(
        "Paymob Order ID missing",
      );
    }

    // ==========================================
    // 5. Find Firestore order
    // ==========================================

    const snapshot =
      await db
        .collection("orders")
        .where(
          "payment.paymobOrderId",
          "==",
          String(
            paymobOrderId,
          ),
        )
        .limit(1)
        .get();

    if (snapshot.empty) {
      throw new Error(
        `Order not found for Paymob order ${paymobOrderId}`,
      );
    }

    const orderDoc =
      snapshot.docs[0];

    const orderRef =
      orderDoc.ref;

    const order =
      orderDoc.data();

    // ==========================================
    // 6. Already paid
    // ==========================================

    if (
      order.paymentStatus ===
      "paid"
    ) {
      return response({
        success: true,
      });
    }

    // ==========================================
    // 7. Verify amount
    // ==========================================

    const expectedAmount =
      Math.round(
        Number(
          order.totalPrice,
        ) * 100,
      );

    const receivedAmount =
      Number(
        payment.amount_cents,
      );

    if (
      expectedAmount !==
      receivedAmount
    ) {
      console.error(
        "AMOUNT MISMATCH",
        {
          expected:
            expectedAmount,

          received:
            receivedAmount,
        },
      );

      throw new Error(
        "Payment amount does not match order amount",
      );
    }

    // ==========================================
    // 8. Verify currency
    // ==========================================

    if (
      payment.currency !==
      "EGP"
    ) {
      throw new Error(
        "Invalid payment currency",
      );
    }

    // ==========================================
    // 9. Update Firestore
    // ==========================================

    await orderRef.update({
      paymentStatus:
        "paid",

      orderStatus:
        "confirmed",

      "payment.transactionId":
        String(
          transactionId,
        ),

      "payment.paymobOrderId":
        String(
          paymobOrderId,
        ),

      "payment.paidAt":
        new Date()
          .toISOString(),

      updatedAt:
        new Date()
          .toISOString(),
    });

    console.log(
      "ORDER PAID:",
      orderDoc.id,
    );

    return response({
      success: true,
    });
  } catch (error) {
    console.error(
      "PAYMOB WEBHOOK ERROR:",
      error,
    );

    return response(
      {
        success: false,

        message:
          error instanceof Error
            ? error.message
            : "Webhook failed",
      },
      500,
    );
  }
});