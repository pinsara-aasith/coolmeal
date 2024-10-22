// app/api/auth/register.ts

import { User } from "@/database/schema";
import connectToDatabase from "@/lib/db";
import bcrypt from "bcryptjs";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  await connectToDatabase();
  try {
    const reqUrl = req.url
    const { searchParams } = new URL(reqUrl)
    const [ email, password, name ] = [
      searchParams.get("email") || 'admin@gmail.com',
      searchParams.get("password") || 'password',
      searchParams.get("name") || 'Coolmeal Admin',
    ]
    
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return NextResponse.json(
        { message: "User already exists" },
        { status: 201 }
      );
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ email, password: hashedPassword, name });

    await newUser.save();
    return NextResponse.json({ message: "User registered successfully" });
  } catch (error) {
    console.error(error)
    return NextResponse.json(
      { message: "An error occurred. Please try again.", error },
      { status: 500 }
    );
  }
}
