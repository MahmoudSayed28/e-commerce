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
    const { obj } = req.body;

    if (!obj) {
      console.log("🔥 INVALID PAYLOAD - OBJ MISSING");

      return res.status(400).json({
        success: false,
        message: "Invalid webhook payload",
      });
    }

    const paymobOrderId =
      String(obj.order?.id ?? "");

    const transactionId =
      String(obj.id ?? "");

    console.log(
      "🔥 PAYMOB ORDER ID:",
      paymobOrderId,
    );

    console.log(
      "🔥 TRANSACTION ID:",
      transactionId,
    );

    console.log(
      "🔥 PAYMENT SUCCESS:",
      obj.success,
    );

    if (!paymobOrderId) {
      return res.status(400).json({
        success: false,
        message: "Paymob order ID is missing",
      });
    }

    /*
     * Paymob Transaction Callback sends HMAC
     * as a query parameter.
     */
    const receivedHmac =
      typeof req.query.hmac === "string"
        ? req.query.hmac
        : null;

    console.log(
      "🔥 HMAC RECEIVED:",
      !!receivedHmac,
    );

    if (!receivedHmac) {
      console.log("🔥 HMAC MISSING");

      return res.status(401).json({
        success: false,
        message: "HMAC missing",
      });
    }

    const secret =
      process.env.PAYMOB_HMAC_SECRET;

    if (!secret) {
      throw new Error(
        "PAYMOB_HMAC_SECRET is missing",
      );
    }

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

    const calculatedHmac =
      crypto
        .createHmac("sha512", secret)
        .update(hmacString)
        .digest("hex");

    if (
      calculatedHmac.toLowerCase() !==
      receivedHmac.toLowerCase()
    ) {
      console.log("🔥 INVALID HMAC");

      return res.status(401).json({
        success: false,
        message: "Invalid HMAC",
      });
    }

    console.log("🔥 HMAC VALID");

    /*
     * Find the local order using Paymob Order ID.
     */
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

    const orderData =
      orderDoc.data();

    /*
     * Prevent duplicate webhook processing.
     */
    if (
      orderData.paymentStatus === "paid"
    ) {
      console.log(
        "🔥 PAYMENT ALREADY PROCESSED",
      );

      return res.status(200).json({
        success: true,
        message: "Payment already processed",
      });
    }

    const isSuccessful =
      obj.success === true ||
      obj.success === "true";

    console.log(
      "🔥 PROCESSING PAYMENT:",
      isSuccessful,
    );

    if (isSuccessful) {
      await orderDoc.ref.update({
        paymentStatus: "paid",
        orderStatus: "paid",

        "payment.paymentStatus": "paid",
        "payment.transactionId":
          transactionId,

        updatedAt:
          new Date().toISOString(),
      });

      console.log(
        "🔥 ORDER UPDATED SUCCESSFULLY",
      );
    } else {
      await orderDoc.ref.update({
        paymentStatus: "failed",
        orderStatus: "payment_failed",

        "payment.paymentStatus": "failed",
        "payment.transactionId":
          transactionId,

        updatedAt:
          new Date().toISOString(),
      });

      console.log(
        "🔥 ORDER UPDATED AS FAILED",
      );
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