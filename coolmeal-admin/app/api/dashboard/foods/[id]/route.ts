import { db } from "@/app/api/config/firebase";
import {
  deleteDoc,
  doc,
  FieldValue,
  getDoc,
  updateDoc,
} from "firebase/firestore";
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
      return NextResponse.json(
        { message: "Food item is not found" },
        { status: 404 }
      );
    }

    const userDetails = foodItemDoc.data(); // User data
    return NextResponse.json(userDetails); // Return the user data as JSON
  } catch (error) {
    console.error("Error fetching Food item details: ", error);
    return NextResponse.json(
      { message: "Error fetching Food item details" },
      { status: 500 }
    );
  }
}

export async function PUT(req: NextRequest, { params }: Props) {
  try {
    if (!params.id) {
      return NextResponse.json(
        { message: "Food ID is required" },
        { status: 400 }
      );
    }

    const foodItemDocRef = doc(db, "ingredients", params.id); // Reference to the specific document
    await deleteDoc(foodItemDocRef); // Delete the document

    return NextResponse.json({ message: "Food item delete successfully" });
  } catch (error) {
    console.error("Error deleting food item details: ", error);
    return NextResponse.json(
      { message: "Error deleting food item" },
      { status: 500 }
    );
  }
}

export async function PATCH(req: NextRequest, { params }: Props) {
  try {
    if (!params.id) {
      return NextResponse.json(
        { message: "Food ID is required" },
        { status: 400 }
      );
    }

    const foodData: {
      foodName?: string;
      foodCode?: string;
      priceCode?: string;
      energyKcal?: string;
      proteinG?: string;
      totalFatG?: string;
      carbohydratesG?: string;
      totalDietaryFibreG?: string;
      freeSugarG?: string;
      starchG?: string;
      vitaminAUg?: string;
      vitaminDUg?: string;
      vitaminKUg?: string;
      vitaminEMg?: string;
      calciumMg?: string;
      phosphorusMg?: string;
      magnesiumMg?: string;
      sodiumMg?: string;
      potassiumMg?: string;
      monounsaturatedFattyAcidsMg?: string;
      polyunsaturatedFattyAcidsMg?: string;
      saturatedFattyAcidsMg?: string;
    } = await req.json();

    const foodItemDocRef = doc(db, "ingredients", params.id); // Reference to the specific document

    // Fetch the existing document
    const existingDoc = await getDoc(foodItemDocRef);

    // If the document doesn't exist, return an error
    if (!existingDoc.exists()) {
      return NextResponse.json(
        { message: "Food item not found" },
        { status: 404 }
      );
    }

    // Create an update object based on provided data, filtering out empty values
    const updatedFields: { [key: string]: string | FieldValue } =
      Object.fromEntries(
        Object.entries(foodData).filter(([_, value]) => value !== "")
      );

    // Update the document with the new data
    await updateDoc(foodItemDocRef, updatedFields);

    // Fetch the updated document
    const updatedDoc = await getDoc(foodItemDocRef);
    const updatedData = updatedDoc.data();

    return NextResponse.json({
      message: "Food item updated successfully",
      data: updatedData,
    });
  } catch (error) {
    console.error("Error updating food item: ", error);
    return NextResponse.json(
      { message: "Error updating food item" },
      { status: 500 }
    );
  }
}
