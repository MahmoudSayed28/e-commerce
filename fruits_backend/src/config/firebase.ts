import "dotenv/config";

import { cert, getApps, initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

const rawServiceAccount = process.env.FIREBASE_SERVICE_ACCOUNT;

if (!rawServiceAccount) {
  throw new Error("FIREBASE_SERVICE_ACCOUNT is missing");
}

let serviceAccount: object;

try {
  serviceAccount = JSON.parse(rawServiceAccount);
} catch {
  throw new Error("FIREBASE_SERVICE_ACCOUNT contains invalid JSON");
}

if (!getApps().length) {
  initializeApp({
    credential: cert(serviceAccount),
  });
}

export const db = getFirestore();