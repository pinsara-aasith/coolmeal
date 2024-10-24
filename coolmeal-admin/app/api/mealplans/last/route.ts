"use server";
import { NextRequest, NextResponse } from "next/server";

const API_URL = process.env.SERVER_SERVICE_URL;
// Accessing the API URL from the environment variables

// Fetch all mealplans
export async function GET() {
  try {
    const response = await fetch(`${API_URL}/mealplans/last`);
    const data = await response.json();
    console.log(data);
    return NextResponse.json(data, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "Failed to fetch meal plans" },
      { status: 500 }
    );
  }
}
