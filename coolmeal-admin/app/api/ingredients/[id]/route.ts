import { NextRequest, NextResponse } from 'next/server';

const API_URL = process.env.NEXT_PUBLIC_API_URL; 

export async function PUT(req: NextRequest, { params }: { params: { id: string } }) {
    const { id } = params;

    try {
        const body = await req.json();
        const response = await fetch(`${API_URL}/ingredients/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(body),
        });

        const data = await response.json();
        return NextResponse.json(data, { status: 200 });
    } catch (error) {
        return NextResponse.json({ error: 'Failed to update ingredient' }, { status: 500 });
    }
}

// Delete an ingredient
export async function DELETE(req: NextRequest, { params }: { params: { id: string } }) {
    const { id } = params;

    try {
        const response = await fetch(`${API_URL}/ingredients/${id}`, {
            method: 'DELETE',
        });

        if (response.ok) {
            return NextResponse.json({}, { status: 204 });
        } else {
            return NextResponse.json({ error: 'Failed to delete ingredient' }, { status: 500 });
        }
    } catch (error) {
        return NextResponse.json({ error: 'Failed to delete ingredient' }, { status: 500 });
    }
}
