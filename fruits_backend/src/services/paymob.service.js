import { db } from "../config/firebase.js";
function getEnv(name) {
    const value = process.env[name];
    if (!value) {
        throw new Error(`${name} is missing`);
    }
    return value;
}
const PAYMOB_SECRET_KEY = getEnv("PAYMOB_SECRET_KEY");
const PAYMOB_PUBLIC_KEY = getEnv("PAYMOB_PUBLIC_KEY");
const PAYMOB_INTEGRATION_ID = getEnv("PAYMOB_INTEGRATION_ID");
export async function createPaymobPayment(orderId) {
    const orderRef = db.collection("orders").doc(orderId);
    const orderDoc = await orderRef.get();
    if (!orderDoc.exists) {
        throw new Error("Order not found");
    }
    const order = orderDoc.data();
    if (!order) {
        throw new Error("Order data not found");
    }
    if (order.payment?.paymentMethod !== "card") {
        throw new Error("This order is not configured for card payment");
    }
    if (order.payment?.paymentStatus === "paid") {
        throw new Error("Order is already paid");
    }
    const totalPrice = Number(order.totalPrice);
    if (!Number.isFinite(totalPrice) || totalPrice <= 0) {
        throw new Error("Invalid order totalPrice");
    }
    const amountCents = Math.round(totalPrice * 100);
    const shippingAddress = order.shippingAddress ?? {};
    const email = shippingAddress.email ??
        order.email ??
        order.customer?.email ??
        "customer@example.com";
    const name = shippingAddress.name ??
        order.customer?.name ??
        "Customer";
    const nameParts = String(name)
        .trim()
        .split(/\s+/);
    const firstName = nameParts[0] || "Customer";
    const lastName = nameParts.slice(1).join(" ") || "Customer";
    const phone = shippingAddress.phone ??
        order.customer?.phone ??
        "01000000000";
    const city = shippingAddress.city ??
        "Cairo";
    const street = shippingAddress.details ??
        shippingAddress.d ??
        "NA";
    const items = Array.isArray(order.products)
        ? order.products.map((product) => ({
            name: product.name ??
                product.title ??
                "Product",
            amount: Math.round(Number(product.price ??
                product.unitPrice ??
                0) * 100),
            description: product.name ??
                product.title ??
                "Product",
            quantity: Number(product.quantity ?? 1),
        }))
        : [];
    const payload = {
        amount: amountCents,
        currency: "EGP",
        payment_methods: [
            Number(PAYMOB_INTEGRATION_ID),
        ],
        items,
        billing_data: {
            apartment: "NA",
            floor: "NA",
            first_name: firstName,
            last_name: lastName,
            street,
            building: "NA",
            phone_number: phone,
            shipping_method: "PKG",
            postal_code: "NA",
            city,
            state: city,
            country: "EG",
            email,
        },
        customer: {
            first_name: firstName,
            last_name: lastName,
            email,
            phone_number: phone,
        },
    };
    const response = await fetch("https://accept.paymob.com/v1/intention/", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            Authorization: `Token ${PAYMOB_SECRET_KEY}`,
        },
        body: JSON.stringify(payload),
    });
    const responseText = await response.text();
    let data;
    try {
        data = JSON.parse(responseText);
    }
    catch {
        throw new Error(`Paymob returned invalid JSON: ${responseText}`);
    }
    if (!response.ok) {
        console.error("PAYMOB INTENTION ERROR:", data);
        throw new Error(data?.detail ??
            data?.message ??
            `Paymob request failed with status ${response.status}`);
    }
    const clientSecret = data.client_secret;
    if (typeof clientSecret !== "string" ||
        clientSecret.length === 0) {
        console.error("PAYMOB RESPONSE:", data);
        throw new Error("Paymob client_secret is missing");
    }
    const intentionId = data.id ??
        data.intention_id ??
        null;
    const paymobOrderId = data.intention_order_id ??
        data.order?.id ??
        null;
    await orderRef.update({
        "payment.intentionId": intentionId !== null
            ? String(intentionId)
            : null,
        "payment.paymobOrderId": paymobOrderId !== null
            ? String(paymobOrderId)
            : null,
        "payment.paymentStatus": "awaiting_payment",
        orderStatus: "awaiting_payment",
        updatedAt: new Date().toISOString(),
    });
    const paymentUrl = `https://accept.paymob.com/unifiedcheckout/` +
        `?publicKey=${encodeURIComponent(PAYMOB_PUBLIC_KEY)}` +
        `&clientSecret=${encodeURIComponent(clientSecret)}`;
    return {
        paymentUrl,
        clientSecret,
        intentionId,
        paymobOrderId,
    };
}
//# sourceMappingURL=paymob.service.js.map