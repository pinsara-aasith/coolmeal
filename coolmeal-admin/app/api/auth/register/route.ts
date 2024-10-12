// app/api/auth/register.ts

import { db } from "@/app/lib/db";
import userModel from "@/app/lib/userModel";
import bcrypt from "bcryptjs";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  await db();
  try {
    const { email, password } = await req.json();

    const existingUser = await userModel.findOne({ email });
    if (existingUser) {
      return NextResponse.json(
        { message: "User already exists" },
        { status: 201 }
      );
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new userModel({ email, password: hashedPassword });

    await newUser.save();
    return NextResponse.json({ message: "User registered successfully" });
  } catch (error) {
    return NextResponse.json(
      { message: "An error occurred. Please try again.", error },
      { status: 500 }
    );
  }
}
