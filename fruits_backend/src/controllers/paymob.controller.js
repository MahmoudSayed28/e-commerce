import crypto from "node:crypto";
import { db } from "../config/firebase.js";
import { createPaymobPayment } from "../services/paymob.service.js";
export async function createPayment(req, res) {
    try {
        const { orderId } = req.body;
        if (typeof orderId !== "string" ||
            orderId.trim().length === 0) {
            return res.status(400).json({
                success: false,
                message: "orderId is required",
            });
        }
        const result = await createPaymobPayment(orderId);
        return res.status(200).json({
            success: true,
            ...result,
        });
    }
    catch (error) {
        console.error("CREATE PAYMOB PAYMENT ERROR:", error);
        return res.status(500).json({
            success: false,
            message: error instanceof Error
                ? error.message
                : "Payment creation failed",
        });
    }
}
export async function paymobWebhook(req, res) {
    try {
        const { obj, hmac, } = req.body;
        if (!obj || typeof hmac !== "string") {
            return res.status(400).json({
                success: false,
                message: "Invalid webhook payload",
            });
        }
        const secret = process.env.PAYMOB_HMAC_SECRET;
        if (!secret) {
            throw new Error("PAYMOB_HMAC_SECRET is missing");
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
        const calculatedHmac = crypto
            .createHmac("sha512", secret)
            .update(hmacString)
            .digest("hex");
        if (calculatedHmac.toLowerCase() !==
            hmac.toLowerCase()) {
            return res.status(401).json({
                success: false,
                message: "Invalid HMAC",
            });
        }
        const paymobOrderId = String(obj.order?.id ?? "");
        if (!paymobOrderId) {
            return res.status(400).json({
                success: false,
                message: "Paymob order ID is missing",
            });
        }
        const ordersSnapshot = await db
            .collection("orders")
            .where("payment.paymobOrderId", "==", paymobOrderId)
            .limit(1)
            .get();
        if (ordersSnapshot.empty) {
            return res.status(404).json({
                success: false,
                message: "Order not found",
            });
        }
        const orderDoc = ordersSnapshot.docs[0];
        if (!orderDoc) {
            return res.status(404).json({
                success: false,
                message: "Order not found",
            });
        }
        const orderData = orderDoc.data();
        // Idempotency:
        // Don't process the same successful payment twice.
        if (orderData.payment?.paymentStatus ===
            "paid") {
            return res.status(200).json({
                success: true,
                message: "Payment already processed",
            });
        }
        const isSuccessful = obj.success === true ||
            obj.success === "true";
        if (isSuccessful) {
            await orderDoc.ref.update({
                "payment.paymentStatus": "paid",
                orderStatus: "paid",
                "payment.paymobTransactionId": String(obj.id),
                "payment.paidAt": new Date().toISOString(),
            });
        }
        else {
            await orderDoc.ref.update({
                "payment.paymentStatus": "failed",
                orderStatus: "payment_failed",
                "payment.paymobTransactionId": String(obj.id),
            });
        }
        return res.status(200).json({
            success: true,
            message: "Webhook processed",
        });
    }
    catch (error) {
        console.error("PAYMOB WEBHOOK ERROR:", error);
        return res.status(500).json({
            success: false,
            message: error instanceof Error
                ? error.message
                : "Webhook processing failed",
        });
    }
}
//# sourceMappingURL=paymob.controller.js.map