import { db } from "@/app/api/config/firebase"; // Assuming your firebase config is here
import { collection, getDocs } from "firebase/firestore"; // Firestore functions
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    const user = collection(db, "user_profiles");
    const userSnapshot = await getDocs(user);
    const userDetails = userSnapshot.docs.map((doc) => ({
      id: doc.id, // Firestore document ID
      ...doc.data(),
    }));
    console.log(userDetails);
    return NextResponse.json(userDetails);
  } catch (error) {
    console.error("Error fetching user details: ", error);
    return NextResponse.json({ message: "Error fetching user details" });
  }
}

// export const fetchUsers = async () => {
//   try {
//     const user = collection(db, "user_profiles");
//     const userSnapshot = await getDocs(user);
//     const userDetails = userSnapshot.docs.map((doc) => ({
//       id: doc.id, // Firestore document ID
//       ...doc.data(),
//     }));
//     return userDetails;
//   } catch (error) {
//     console.error("Error fetching user details: ", error);
//     return { message: "Error fetching user details" };
//   }
// };
