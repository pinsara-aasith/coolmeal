import NextAuth from "next-auth";
// import { authConfig } from "./auth.config";

// export default NextAuth(authConfig).auth;

// export const config = {
//   // https://nextjs.org/docs/app/building-your-application/routing/middleware#matcher
//   matcher: ["/((?!api|_next/static|_next/image|.*\\.png$).*)"],
// };
import { NextResponse } from "next/server";

export default function middleware(req: {
  cookies: { get: (arg0: string) => any };
  url: string | URL | undefined;
}) {
  // Example: Redirect user to login if not authenticated
  const token = req.cookies.get("authjs.session-token");

  if (!token) {
    return NextResponse.redirect(new URL("/login", req.url));
  }

  return NextResponse.next(); // Proceed to the requested route
}

export const config = {
  matcher: ["/dashboard/:path*"], // Apply middleware to specific routes
};
