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
        { message: "User ID is required" },
        { status: 400 }
      );
    }

    const userDocRef = doc(db, "user_profiles", params.id); // Reference to the specific document
    const userDoc = await getDoc(userDocRef); // Fetch the document

    if (!userDoc.exists()) {
      return NextResponse.json({ message: "User not found" }, { status: 404 });
    }

    const userDetails = userDoc.data(); // User data
    return NextResponse.json(userDetails); // Return the user data as JSON
  } catch (error) {
    console.error("Error fetching user details: ", error);
    return NextResponse.json(
      { message: "Error fetching user details" },
      { status: 500 }
    );
  }
}
