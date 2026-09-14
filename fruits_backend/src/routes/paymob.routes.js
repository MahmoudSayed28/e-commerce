import { Router } from "express";
import { createPayment, paymobWebhook, } from "../controllers/paymob.controller.js";
const router = Router();
router.post("/create-payment", createPayment);
router.post("/webhook", paymobWebhook);
export default router;
//# sourceMappingURL=paymob.routes.js.map