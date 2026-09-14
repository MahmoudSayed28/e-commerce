import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import paymobRoutes from "./routes/paymob.routes.js";
dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
app.get("/health", (req, res) => {
    res.json({
        success: true,
        message: "Fruits Backend is running 🚀",
    });
});
app.use("/api/paymob", paymobRoutes);
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
//# sourceMappingURL=server.js.map