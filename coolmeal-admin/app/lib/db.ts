import mongoose from "mongoose";

//connecting to mongodb
export const db = async () => {
  const mongoURL = process.env.MONGODB_URI;
  await mongoose.connect(mongoURL!).then(() => {
    console.log("Connected to MongoDB");
  });
};
