'use server'
import { NextRequest, NextResponse } from 'next/server';

const API_URL = process.env.SERVER_SERVICE_URL; 
// Accessing the API URL from the environment variables

// Fetch all ingredients
export async function GET() {
    try {
        const response = await fetch(`${API_URL}/ingredients`);
        const data = await response.json();
        return NextResponse.json(data, { status: 200 });
    } catch (error) {
        console.error(error)
        return NextResponse.json({ error: 'Failed to fetch ingredients' }, { status: 500 });
    }
}

// Add a new ingredient
export async function POST(req: NextRequest) {
    try {
        const body = await req.json();

        const response = await fetch(`${API_URL}/ingredients`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(body),
        });

        const data = await response.json();
        return NextResponse.json(data, { status: 201 });
    } catch (error) {
        return NextResponse.json({ error: 'Failed to add ingredient' }, { status: 500 });
    }
}
