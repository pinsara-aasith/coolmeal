import { NextRequest, NextResponse } from "next/server";
import NextAuth from "next-auth";
import { authOptions } from "./lib/authOptions";

const { auth } = NextAuth(authOptions);

export const LOGIN = '/login';
export const ROOT = '/';

export const PUBLIC_ROUTES = [
  '/login',
  '/register',
  '/api/auth/callback/google',
  '/api/auth/callback/github',
]

export const PROTECTED_SUB_ROUTES = [
  '/dashboard',
]


export async function middleware(request: NextRequest) {
  const { nextUrl } = request;
  const session = await auth();
  const isAuthenticated = !!session?.user;

  const isPublicRoute = (
    (PUBLIC_ROUTES.find(route => nextUrl.pathname.startsWith(route))
    ) && !PROTECTED_SUB_ROUTES.find(route => nextUrl.pathname.startsWith(route)))
    && nextUrl.pathname != ROOT;

  if (!isAuthenticated && !isPublicRoute)
    return Response.redirect(new URL(LOGIN, nextUrl));
}


// See "Matching Paths" below to learn more
export const config = {
  /*
   * Match all request paths except for the ones starting with:
   * - api (API routes)
   * - _next/static (static files)
   * - favicon.ico (favicon file)
   */
  matcher: '/((?!api|_next/static|_next/images|static|favicon.ico|favicon.png).*)',
}
