const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }

  try {
    const {
      amount,
      currency = "EGP",
      firstName,
      lastName,
      email,
      phone,
    } = await req.json();

    const apiKey = Deno.env.get("PAYMOB_API_KEY");
    const integrationId = Deno.env.get("PAYMOB_INTEGRATION_ID");

    if (!apiKey || !integrationId) {
      throw new Error("Missing Paymob secrets");
    }

    //==============================
    // 1- Authentication Token
    //==============================

    const authResponse = await fetch(
      "https://accept.paymob.com/api/auth/tokens",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          api_key: apiKey,
        }),
      },
    );

    const authData = await authResponse.json();

    if (!authResponse.ok) {
      throw new Error(JSON.stringify(authData));
    }

    const authToken = authData.token;

    //==============================
    // 2- Create Order
    //==============================

    const orderResponse = await fetch(
      "https://accept.paymob.com/api/ecommerce/orders",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          auth_token: authToken,
          delivery_needed: "false",
          amount_cents: (amount * 100).toString(),
          currency,
          items: [],
        }),
      },
    );

    const orderData = await orderResponse.json();

    if (!orderResponse.ok) {
      throw new Error(JSON.stringify(orderData));
    }

    const orderId = orderData.id;

    //==============================
    // 3- Generate Payment Key
    //==============================

    const paymentResponse = await fetch(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          expiration: 3600,
          auth_token: authToken,
          order_id: orderId.toString(),
          integration_id: Number(integrationId),
          amount_cents: (amount * 100).toString(),
          currency,

          billing_data: {
            apartment: "NA",
            floor: "NA",
            first_name: firstName,
            last_name: lastName,
            street: "NA",
            building: "NA",
            phone_number: phone,
            shipping_method: "NA",
            postal_code: "NA",
            city: "NA",
            country: "EG",
            email: email,
            state: "NA",
          },
        }),
      },
    );

    const paymentData = await paymentResponse.json();

    if (!paymentResponse.ok) {
      throw new Error(JSON.stringify(paymentData));
    }

    return new Response(
      JSON.stringify({
        success: true,
        paymentKey: paymentData.token,
      }),
      {
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (e) {
    return new Response(
      JSON.stringify({
        success: false,
        message: e.toString(),
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