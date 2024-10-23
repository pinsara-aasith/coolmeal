"use server";
import { NextRequest, NextResponse } from "next/server";

const API_URL = process.env.SERVER_SERVICE_URL;
// Accessing the API URL from the environment variables

// Fetch all meals
// export async function GET() {
//     try {
//         const response = await fetch(`${API_URL}/meals`);
//         const data = await response.json();
//         return NextResponse.json(data, { status: 200 });
//     } catch (error) {
//         console.error(error)
//         return NextResponse.json({ error: 'Failed to fetch meals' }, { status: 500 });
//     }
// }

// Add a new meal
export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData(); // Extract FormData from the request
    const file = formData.get("file") as File | null; // Get the file object

    if (!file) {
      return NextResponse.json({ error: "No file uploaded" }, { status: 400 });
    }

    // Create a new FormData instance to send to the FastAPI server
    const uploadFormData = new FormData();
    uploadFormData.append("file", file);

    // Send the file to the FastAPI server
    const response = await fetch(`${API_URL}/upload-pdf/`, {
      method: "POST",
      body: uploadFormData,
    });

    if (!response.ok) {
      throw new Error("Failed to upload PDF to FastAPI");
    }

    const data = await response.json();
    return NextResponse.json(data, { status: 200 });
  } catch (error) {
    console.error("Error in uploading PDF:", error);
    return NextResponse.json(
      { error: "Failed to upload PDF" },
      { status: 500 }
    );
  }
}
