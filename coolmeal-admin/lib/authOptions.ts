import bcrypt from "bcryptjs";
import NextAuth, { NextAuthConfig } from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";

export const authOptions: NextAuthConfig = {
  providers: [
    CredentialsProvider({
      name: "Credentials",
      id: "credentials",
      credentials: {
        email: { label: "Email", type: "text" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials: any) {
        if (credentials === null) return null;

        try {

          const _adminEmail = process.env.COOLMEAL_ADMIN_USER_NAME
          const _adminPassword = process.env.COOLMEAL_ADMIN_PASSWORD
          if (credentials.email == _adminEmail && credentials.password == _adminPassword) {
            return {
              email: _adminEmail,
              name: "Cool Admin",
              id: _adminEmail
            };
          } else {
            throw new Error("Email or Password is not correct");
          }

        } catch (error) {
          throw new Error(error as any);
        }
      },
    }),
  ],
  session: {
    strategy: "jwt",
  },
};

export const {
  handlers: { GET, POST },
  auth,
  signIn,
  signOut,
} = NextAuth(authOptions);
