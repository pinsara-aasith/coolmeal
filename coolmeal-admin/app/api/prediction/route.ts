'use server';
import { NextRequest, NextResponse } from 'next/server';

const API_URL = process.env.SERVER_SERVICE_URL;

export async function POST(req: NextRequest) {
    try {
        const body = await req.json();

        // Validate incoming request body
        

        const response = await fetch(`${API_URL}/prediction`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(body),
        });

        if (!response.ok) {
            const errorData = await response.json();
            return NextResponse.json(errorData, { status: response.status });
        }

        const data = await response.json();
        return NextResponse.json(data, { status: 201 });
    } catch (error) {
        console.error('Prediction API error:', error);
        return NextResponse.json(
            { error: 'Internal Server Error' },
            { status: 500 }
        );
    }
}
