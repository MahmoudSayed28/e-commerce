const PAYMOB_API_KEY = Deno.env.get("PAYMOB_API_KEY")!;
const PAYMOB_INTEGRATION_ID = Deno.env.get("PAYMOB_INTEGRATION_ID")!;
const PAYMOB_IFRAME_ID = Deno.env.get("PAYMOB_IFRAME_ID")!;

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  if (req.method !== "POST") {
    return new Response(
      JSON.stringify({
        success: false,
        message: "POST only",
      }),
      {
        status: 405,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }

  try {
    console.log("========== CREATE PAYMOB PAYMENT ==========");
    console.log("PAYMOB_INTEGRATION_ID =", PAYMOB_INTEGRATION_ID);
    console.log("PAYMOB_IFRAME_ID =", PAYMOB_IFRAME_ID);

    const body = await req.json();

    console.log("REQUEST:");
    console.log(JSON.stringify(body, null, 2));

    const {
      amount,
      currency,
      firstName,
      lastName,
      email,
      phone,
      order,
    } = body;

    // ================= AUTH =================

    const authResponse = await fetch(
      "https://accept.paymob.com/api/auth/tokens",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          api_key: PAYMOB_API_KEY,
        }),
      },
    );

    const authData = await authResponse.json();

    console.log("AUTH:");
    console.log(JSON.stringify(authData, null, 2));

    if (!authData.token) {
      throw new Error("Paymob Authentication Failed");
    }

    // ================= ORDER =================

    const orderResponse = await fetch(
      "https://accept.paymob.com/api/ecommerce/orders",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          auth_token: authData.token,
          delivery_needed: false,
          amount_cents: Math.round(Number(amount) * 100),
          currency,
          items: [],
        }),
      },
    );

    const orderData = await orderResponse.json();

    console.log("ORDER:");
    console.log(JSON.stringify(orderData, null, 2));

    if (!orderData.id) {
      throw new Error("Paymob Order Creation Failed");
    }

    // ================= PAYMENT KEY =================

    const paymentPayload = {
      auth_token: authData.token,
      amount_cents: Math.round(Number(amount) * 100),
      expiration: 3600,
      order_id: orderData.id,
      currency,
      integration_id: Number(PAYMOB_INTEGRATION_ID),

      billing_data: {
        apartment: "NA",
        email,
        floor: "NA",
        first_name: firstName,
        last_name: lastName,
        street: "NA",
        building: "NA",
        phone_number: phone,
        shipping_method: "NA",
        postal_code: "NA",
        city: "NA",
        state: "NA",
        country: "EG",
      },

      extra: {
        order,
      },

      lock_order_when_paid: false,
    };

    console.log("PAYMENT PAYLOAD:");
    console.log(JSON.stringify(paymentPayload, null, 2));

    const paymentResponse = await fetch(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(paymentPayload),
      },
    );

    const paymentData = await paymentResponse.json();

    console.log("PAYMENT RESPONSE:");
    console.log(JSON.stringify(paymentData, null, 2));

    if (!paymentData.token) {
      throw new Error("Payment Key Creation Failed");
    }

    return new Response(
      JSON.stringify({
        success: true,
        paymentKey: paymentData.token,
        orderId: orderData.id,
        integrationId: PAYMOB_INTEGRATION_ID,
        paymentUrl:
          `https://accept.paymob.com/api/acceptance/iframes/${PAYMOB_IFRAME_ID}?payment_token=${paymentData.token}`,
      }),
      {
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (e) {
    console.error(e);

    return new Response(
      JSON.stringify({
        success: false,
        message: e instanceof Error ? e.message : String(e),
      }),
      {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});