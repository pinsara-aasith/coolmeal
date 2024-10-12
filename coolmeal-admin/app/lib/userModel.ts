import mongoose from "mongoose";

const userSchema = new mongoose.Schema(
  {
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
  },
  { minimize: false }
);

// Reuse existing model if it exists, or create a new one
const userModel = mongoose.models.user || mongoose.model("user", userSchema);
console.log("model", mongoose.models);

export default userModel;
