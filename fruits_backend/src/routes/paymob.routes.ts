import { Router } from "express";

import {
  createPayment,
  paymobWebhook,
  paymobResponse,
} from "../controllers/paymob.controller.js";

const router = Router();

router.post(
  "/create-payment",
  createPayment,
);

router.post(
  "/webhook",
  paymobWebhook,
);

router.get(
  "/response",
  paymobResponse,
);

export default router;