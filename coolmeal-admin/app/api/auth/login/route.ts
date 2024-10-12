import { db } from "@/app/lib/db";
import userModel from "@/app/lib/userModel";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  try {
    await db();
    const { email, password } = await req.json();

    const user = await userModel.findOne({ email });
    if (!user) {
      return NextResponse.json({ message: "User not found" });
    }
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return NextResponse.json({ message: "Invalid credentials" });
    }
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET!, {
      expiresIn: "1d",
    });

    return NextResponse.json({ token });
  } catch (error) {
    console.error("Error logging in: ", error);
    return NextResponse.json({ message: "Error logging in" }, { status: 500 });
  }
}
