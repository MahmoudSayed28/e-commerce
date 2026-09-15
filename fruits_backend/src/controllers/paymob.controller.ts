import type { Request, Response } from "express";
import crypto from "node:crypto";

import { db } from "../config/firebase.js";
import { createPaymobPayment } from "../services/paymob.service.js";

export async function createPayment(
  req: Request,
  res: Response,
) {
  try {
    const { orderId } = req.body;

    if (
      typeof orderId !== "string" ||
      orderId.trim().length === 0
    ) {
      return res.status(400).json({
        success: false,
        message: "orderId is required",
      });
    }

    const result =
      await createPaymobPayment(orderId);

    return res.status(200).json({
      success: true,
      ...result,
    });
  } catch (error) {
    console.error(
      "CREATE PAYMOB PAYMENT ERROR:",
      error,
    );

    return res.status(500).json({
      success: false,
      message:
        error instanceof Error
          ? error.message
          : "Payment creation failed",
    });
  }
}

export async function paymobWebhook(
  req: Request,
  res: Response,
) {
  console.log("🔥 PAYMOB WEBHOOK RECEIVED");

  try {
    console.log("🔥 STEP 1");

    const {
      obj,
      hmac,
    } = req.body;

    console.log("🔥 STEP 2");

    if (!obj || typeof hmac !== "string") {
      console.log("🔥 INVALID PAYLOAD");

      return res.status(400).json({
        success: false,
        message: "Invalid webhook payload",
      });
    }

    console.log("🔥 STEP 3");

    const secret =
      process.env.PAYMOB_HMAC_SECRET;

    if (!secret) {
      throw new Error(
        "PAYMOB_HMAC_SECRET is missing",
      );
    }

    console.log("🔥 STEP 4 - HMAC SECRET EXISTS");

    const hmacString = [
      obj.amount_cents,
      obj.created_at,
      obj.currency,
      obj.error_occured,
      obj.has_parent_transaction,
      obj.id,
      obj.integration_id,
      obj.is_3d_secure,
      obj.is_auth,
      obj.is_capture,
      obj.is_refunded,
      obj.is_standalone_payment,
      obj.is_voided,
      obj.order?.id,
      obj.owner,
      obj.pending,
      obj.source_data?.pan,
      obj.source_data?.sub_type,
      obj.source_data?.type,
      obj.success,
    ].join("");

    console.log("🔥 STEP 5 - HMAC STRING CREATED");

    const calculatedHmac = crypto
      .createHmac("sha512", secret)
      .update(hmacString)
      .digest("hex");

    console.log("🔥 STEP 6 - HMAC CALCULATED");

    if (
      calculatedHmac.toLowerCase() !==
      hmac.toLowerCase()
    ) {
      console.log("🔥 INVALID HMAC");

      return res.status(401).json({
        success: false,
        message: "Invalid HMAC",
      });
    }

    console.log("🔥 HMAC VALID");

    const paymobOrderId =
      String(obj.order?.id ?? "");

    console.log(
      "🔥 PAYMOB ORDER ID:",
      paymobOrderId,
    );

    if (!paymobOrderId) {
      console.log("🔥 PAYMOB ORDER ID MISSING");

      return res.status(400).json({
        success: false,
        message: "Paymob order ID is missing",
      });
    }

    console.log("🔥 STEP 7 - SEARCHING FIRESTORE");

    const ordersSnapshot = await db
      .collection("orders")
      .where(
        "payment.paymobOrderId",
        "==",
        paymobOrderId,
      )
      .limit(1)
      .get();

    console.log(
      "🔥 ORDER QUERY EMPTY:",
      ordersSnapshot.empty,
    );

    if (ordersSnapshot.empty) {
      return res.status(404).json({
        success: false,
        message: "Order not found",
      });
    }

    const orderDoc =
      ordersSnapshot.docs[0];

    if (!orderDoc) {
      return res.status(404).json({
        success: false,
        message: "Order not found",
      });
    }

    console.log(
      "🔥 ORDER FOUND:",
      orderDoc.id,
    );

    const orderData = orderDoc.data();

    if (
      orderData.payment?.paymentStatus ===
      "paid"
    ) {
      console.log("🔥 PAYMENT ALREADY PROCESSED");

      return res.status(200).json({
        success: true,
        message: "Payment already processed",
      });
    }

    const isSuccessful =
      obj.success === true ||
      obj.success === "true";

    console.log(
      "🔥 PAYMENT SUCCESS:",
      isSuccessful,
    );

    if (isSuccessful) {
      console.log("🔥 UPDATING ORDER AS PAID");

      await orderDoc.ref.update({
        "payment.paymentStatus": "paid",
        orderStatus: "paid",
        "payment.paymobTransactionId":
          String(obj.id),
        "payment.paidAt":
          new Date().toISOString(),
      });

      console.log("🔥 ORDER UPDATED SUCCESSFULLY");
    } else {
      console.log("🔥 UPDATING ORDER AS FAILED");

      await orderDoc.ref.update({
        "payment.paymentStatus": "failed",
        orderStatus: "payment_failed",
        "payment.paymobTransactionId":
          String(obj.id),
      });

      console.log("🔥 ORDER UPDATED AS FAILED");
    }

    return res.status(200).json({
      success: true,
      message: "Webhook processed",
    });
  } catch (error) {
    console.error(
      "🔥 PAYMOB WEBHOOK ERROR:",
      error,
    );

    return res.status(500).json({
      success: false,
      message:
        error instanceof Error
          ? error.message
          : "Webhook processing failed",
    });
  }
}
export async function paymobResponse(
  req: Request,
  res: Response,
) {

  const success =
    req.query.success === "true";

  return res.status(200).send(
    success
      ? "Payment successful"
      : "Payment failed",
  );
}