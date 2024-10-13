"use server";
import { collection, addDoc, deleteDoc, doc } from "firebase/firestore";
import { db } from "@/app/api/config/firebase"; // Make sure to point to your Firebase configuration
import { revalidatePath } from "next/cache";
// import { signIn, signOut } from "@/auth";
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
    viatminKUg,
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
      viatminKUg,
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

// export const authenticate = async (formData: FormData) => {
//   const { email, password } = Object.fromEntries(formData);
//   console.log("formdata", formData);

//   try {
//     // Call signIn and await the response
//     const result = await signIn("credentials", {
//       redirect: false, // Prevent automatic redirect
//       email,
//       password,
//     });
//     console.log("result", result);

//     // Check the result status
//     if (!result) {
//       console.error("Failed to authenticate user");
//       throw new Error("Failed to authenticate user.");
//     }

//     // If successful, handle accordingly (e.g., navigate to dashboard)
//     console.log("User authenticated successfully");
//   } catch (err) {
//     console.error("Error logging in: ", err);
//     // throw new Error("Failed to authenticate user.");
//   }
// };

// export const logOut = async () => {
//   await signOut();
//   // Your sign-out logic here
// };

// export async function authenticate(
//   prevState: string | undefined,
//   formData: FormData
// ) {
//   try {
//     await signIn("credentials", formData);
//   } catch (error) {
//     if (error instanceof AuthError) {
//       switch (error.type) {
//         case "CredentialsSignin":
//           return "Invalid credentials.";
//         default:
//           return "Something went wrong.";
//       }
//     }
//     throw error;
//   }
// }
