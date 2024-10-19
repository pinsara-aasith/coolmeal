import { collection, getDocs } from "firebase/firestore";
import { NextRequest, NextResponse } from "next/server";
import { db } from "@/app/api/config/firebase";

export async function GET(req: NextRequest) {
  try {
    const meals = collection(db, "meal_plans");
    const mealsSnapshot = await getDocs(meals);
    const mealsDetails = mealsSnapshot.docs.map((doc) => ({
      id: doc.id, // Firestore document ID
      ...doc.data(),
    }));
    return NextResponse.json(mealsDetails);
  } catch (error) {
    console.error("Error fetching meal details: ", error);
    return NextResponse.json({ message: "Error fetching meal details" });
  }
}
