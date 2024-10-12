import { db } from "@/app/api/config/firebase";
import { doc, getDoc } from "firebase/firestore";
import { NextRequest, NextResponse } from "next/server";

interface Props {
  params: {
    id: string;
  };
}

export async function GET(req: NextRequest, { params }: Props) {
  try {
    if (!params.id) {
      return NextResponse.json(
        { message: "Food ID is required" },
        { status: 400 }
      );
    }

    const foodItemDocRef = doc(db, "ingredients", params.id); // Reference to the specific document
    const foodItemDoc = await getDoc(foodItemDocRef); // Fetch the document

    if (!foodItemDoc.exists()) {
      return NextResponse.json({ message: "User not found" }, { status: 404 });
    }

    const userDetails = foodItemDoc.data(); // User data
    return NextResponse.json(userDetails); // Return the user data as JSON
  } catch (error) {
    console.error("Error fetching user details: ", error);
    return NextResponse.json(
      { message: "Error fetching user details" },
      { status: 500 }
    );
  }
}
