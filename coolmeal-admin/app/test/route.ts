import { collection, addDoc } from "firebase/firestore";
import { db } from "@/app/api/config/firebase"; // Assuming your firebase config is here
import { NextRequest, NextResponse } from "next/server";

// Add a new document with a generated id.
export async function POST(req: NextRequest) {
  try {
    // Parse the request body to extract city details
    const { test2, test12, test1 } = await req.json();
    console.log(test1);

    // Validate the received data
    if (!test1 || !test2) {
      return NextResponse.json(
        { message: "Missing name or country fields" },
        { status: 400 }
      );
    }

    // Add the new city to the 'cities' collection in Firestore
    const docRef = await addDoc(collection(db, "test"), {
      test1,
      test2,
    });

    console.log("Document written with ID:", docRef.id);
    return NextResponse.json({
      message: "City added successfully",
      id: docRef.id,
    });
  } catch (error) {
    console.error("Error adding city: ", error);
    return NextResponse.json({ message: "Error adding city" }, { status: 500 });
  }
}
