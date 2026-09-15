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
    console.log("🔥 BODY TYPE:", typeof req.body);

    console.log(
      "🔥 BODY KEYS:",
      req.body &&
          typeof req.body === "object"
        ? Object.keys(req.body)
        : "NOT_OBJECT",
    );

    const { obj } = req.body;

    console.log("🔥 HAS OBJ:", !!obj);

    console.log(
      "🔥 OBJ KEYS:",
      obj && typeof obj === "object"
        ? Object.keys(obj)
        : "NO_OBJ",
    );

    console.log(
      "🔥 CALLBACK TYPE:",
      req.body?.type,
    );

    if (
      !obj 
    ) {
      console.log(
        "🔥 INVALID PAYLOAD - OBJ MISSING",
      );

      return res.status(400).json({
        success: false,
        message: "Invalid webhook payload",
      });
    }

    console.log("🔥 OBJ RECEIVED");

    const paymobOrderId =
      String(obj.order?.id ?? "");

    console.log(
      "🔥 PAYMOB ORDER ID:",
      paymobOrderId,
    );

    if (!paymobOrderId) {
      console.log(
        "🔥 PAYMOB ORDER ID MISSING",
      );

      return res.status(400).json({
        success: false,
        message:
          "Paymob order ID is missing",
      });
    }

    console.log(
      "🔥 TRANSACTION ID:",
      String(obj.id ?? ""),
    );

    console.log(
      "🔥 PAYMENT SUCCESS:",
      obj.success,
    );

 

    console.log(
      "🔥 WEBHOOK RECEIVED - WAITING FOR HMAC VERIFICATION",
    );

    return res.status(200).json({
      success: true,
      message: "Webhook received",
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