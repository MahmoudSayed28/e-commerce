import { initializeApp, cert, getApps } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

const serviceAccount = JSON.parse(
  Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!,
);

if (!getApps().length) {
  initializeApp({
    credential: cert(serviceAccount),
  });
}

const db = getFirestore();

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

  try {
    console.log("========== PAYMOB WEBHOOK ==========");

    // اقرأ الـ Body كنص
    const rawBody = await req.text();

    console.log("RAW BODY:");
    console.log(rawBody);

    // لو الـ Body فاضي تجاهله
    if (!rawBody.trim()) {
      console.log("EMPTY BODY -> IGNORE");
      return Response.json({
        success: true,
      });
    }

    // Parse
    const body = JSON.parse(rawBody);

    console.log("BODY:");
    console.log(JSON.stringify(body, null, 2));

    const payment = body.obj ?? body;

    if (!payment) {
      console.log("NO PAYMENT OBJECT");
      return Response.json({
        success: true,
      });
    }

    console.log("PAYMENT SUCCESS:", payment.success);
    console.log("PAYMENT PENDING:", payment.pending);
    console.log("PAYMENT STATUS:", payment.order?.payment_status);

    // تجاهل أي Callback قبل اكتمال الدفع
    if (
      payment.success !== true ||
      payment.pending === true ||
      payment.order?.payment_status !== "PAID"
    ) {
      console.log("IGNORE CALLBACK");
      return Response.json({
        success: true,
      });
    }

    const order = payment.payment_key_claims?.extra?.order;

    if (!order) {
      throw new Error("Order not found inside payment_key_claims.extra");
    }

    console.log("ORDER:");
    console.log(JSON.stringify(order, null, 2));

    // منع تكرار الحفظ
    const existing = await db
      .collection("orders")
      .where("transactionId", "==", payment.id)
      .limit(1)
      .get();

    if (!existing.empty) {
      console.log("ORDER ALREADY EXISTS");
      return Response.json({
        success: true,
      });
    }

    console.log("START FIRESTORE");

    const doc = await db.collection("orders").add({
      ...order,
      paymobOrderId: payment.order.id,
      transactionId: payment.id,
      paymentStatus: "paid",
      createdAt: new Date().toISOString(),
    });

    console.log("DOCUMENT ID:", doc.id);
    console.log("FIRESTORE DONE");

    return Response.json({
      success: true,
    });

  } catch (e: any) {
    console.log("========== ERROR ==========");
    console.log(e);

    return Response.json({
      success: false,
      error: e.message,
      stack: e.stack,
    });
  }
});