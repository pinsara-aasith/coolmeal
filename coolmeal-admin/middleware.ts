import { NextRequest, NextResponse } from "next/server";
import NextAuth from "next-auth";
import { authOptions } from "./lib/authOptions";

const { auth } = NextAuth(authOptions);

export const LOGIN = "/login";
export const ROOT = "/";

export const PUBLIC_ROUTES = [
  "/login",
  "/register",
  "/api/auth/callback/google",
  "/api/auth/callback/github",
];

export async function middleware(request: NextRequest) {
  const { nextUrl } = request;
  const session = await auth();
  const isAuthenticated = !!session?.user;

  const isPublicRoute =
    PUBLIC_ROUTES.find((route) => nextUrl.pathname.startsWith(route))
    || nextUrl.pathname == '/';

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
  runtime: 'nodejs',
  unstable_allowDynamic: [
    '/node_modules/mongoose/dist/browser.umd.js'
  ],
  matcher:
    "/((?!api|_next/static|_next/images|static|favicon.ico|favicon.png).*)",
};

export const runtime = 'nodejs'