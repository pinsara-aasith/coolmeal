// /pages/api/cities.ts
import type { NextApiRequest, NextApiResponse } from "next";
import { db } from "@/app/api/config/firebase"; // Assuming your firebase config is here
import { collection, getDocs } from "firebase/firestore"; // Firestore functions
import { NextRequest, NextResponse } from "next/server";

// const getCities = async (req: NextApiRequest, res: NextApiResponse) => {
//   try {
//     const citiesCol = collection(db, "user_profiles");
//     const citySnapshot = await getDocs(citiesCol);
//     const cityList = citySnapshot.docs.map((doc) => doc.data());
//     res.status(200).json({ cities: cityList });
//   } catch (error) {
//     console.error("Error fetching cities: ", error);
//     res.status(500).json({ message: "Error fetching cities" });
//   }
// };

// export default getCities;

export async function GET(req: NextRequest) {
  try {
    const user = collection(db, "user_profiles");
    const userSnapshot = await getDocs(user);
    const userDetails = userSnapshot.docs.map((doc) => doc.data());
    return NextResponse.json(userDetails);
  } catch (error) {
    console.error("Error fetching user details: ", error);
    return NextResponse.json({ message: "Error fetching user details" });
  }
}
