"use server";
import { collection, addDoc, deleteDoc, doc } from "firebase/firestore";
import { db } from "@/app/api/config/firebase"; // Make sure to point to your Firebase configuration
import { revalidatePath } from "next/cache";
// import { AuthError } from "next-auth";

export const addFood = async (formData: FormData) => {
  const {
    foodName = "",
    foodCode = 1,
    priceCode = 1,
    energyKcal,
    proteinG,
    totalFatG,
    carbohydratesG,
    totalDietaryFibreG,
    freeSugarG,
    starchG,
    vitaminKUg,
    vitaminDUg,
    vitaminAUg,
    vitaminEMg,
    calciumMg,
    phosphorusMg,
    magnesiumMg,
    sodiumMg,
    potassiumMg,
    monounsaturatedFattyAcidsMg,
    polyunsaturatedFattyAcidsMg,
    saturatedFattyAcidsMg,
  } = Object.fromEntries(formData); // Extract data from formData

  try {
    // Add food data to the Firestore collection
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
      vitaminKUg,
      vitaminDUg,
      vitaminAUg,
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

    console.log("Food item successfully added with ID: ", docRef.id);
  } catch (error) {
    console.error("Error adding food item: ", error);
    throw new Error("Failed to add food item to Firestore.");
  }
};

export const deleteFood = async (foodId: string) => {
  try {
    // Delete food item from Firestore collection
    await deleteDoc(doc(db, `ingredients/${foodId}`));
    console.log("Food item successfully deleted");
  } catch (error) {
    console.error("Error deleting food item: ", error);
    throw new Error("Failed to delete food item from Firestore.");
  }
  revalidatePath("/dashboard/foods");
};
