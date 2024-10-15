import { db } from "@/app/api/config/firebase"; // Assuming your firebase config is here
import { collection, getDocs } from "firebase/firestore"; // Firestore functions
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    const foodItem = collection(db, "ingredients");
    const foodItemSnapshot = await getDocs(foodItem);
    const foodItemDetails = foodItemSnapshot.docs.map((doc) => ({
      id: doc.id, // Firestore document ID
      ...doc.data(),
    }));
    return NextResponse.json(foodItemDetails);
  } catch (error) {
    console.error("Error fetching food details: ", error);
    return NextResponse.json({ message: "Error fetching food details" });
  }
}
