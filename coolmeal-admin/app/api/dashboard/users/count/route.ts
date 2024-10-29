// /api/users/count/route.ts

import { db } from "@/app/api/config/firebase";
import { collection, getDocs } from "firebase/firestore";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    const userCollection = collection(db, "user_profiles");
    const userSnapshot = await getDocs(userCollection);
    const userCount = userSnapshot.size;

    return NextResponse.json({ count: userCount });
  } catch (error) {
    console.error("Error fetching user count: ", error);
    return NextResponse.json({ message: "Error fetching user count" });
  }
}
