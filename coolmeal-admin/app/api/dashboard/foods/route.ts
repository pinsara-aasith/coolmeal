import { db } from "@/app/api/config/firebase"; // Assuming your firebase config is here
import { addDoc, collection, getDocs } from "firebase/firestore"; // Firestore functions
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

// POST function to add data to Firestore
export async function POST(req: NextRequest) {
  try {
    // Parse request body to get form data
    const {
      foodName = "",
      foodCode = "",
      priceCode = "",
      energyKcal = "",
      proteinG = "",
      totalFatG = "",
      carbohydratesG = "",
      totalDietaryFibreG = "",
      freeSugarG = "",
      starchG = "",
      vitaminAUg = "",
      vitaminDUg = "",
      vitaminKUg = "",
      vitaminEMg = "",
      calciumMg = "",
      phosphorusMg = "",
      magnesiumMg = "",
      sodiumMg = "",
      potassiumMg = "",
      monounsaturatedFattyAcidsMg = "",
      polyunsaturatedFattyAcidsMg = "",
      saturatedFattyAcidsMg = "",
    } = await req.json();

    // Add the new food item to the 'ingredients' collection in Firestore
    const docRef = await addDoc(collection(db, "ingredients"), {
      foodName,
      foodCode,
      priceCode,
      energyKcal,
      proteinG,
      totalFatG,
      carbohydratesG,
      totalDietaryFibreG,
      freeSugarG,
      starchG,
      vitaminAUg,
      vitaminDUg,
      vitaminKUg,
      vitaminEMg,
      calciumMg,
      phosphorusMg,
      magnesiumMg,
      sodiumMg,
      potassiumMg,
      monounsaturatedFattyAcidsMg,
      polyunsaturatedFattyAcidsMg,
      saturatedFattyAcidsMg,
    });

    console.log("Food item added with ID:", docRef.id);
    console.log(docRef);
    return NextResponse.json({
      message: "Food item successfully added",
      id: docRef.id,
    });
  } catch (error) {
    console.error("Error adding food item: ", error);
    return NextResponse.json({
      message: "Error adding food item",
      // error: error.message,
    });
  }
}
