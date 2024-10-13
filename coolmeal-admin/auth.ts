// import NextAuth from "next-auth";
// import CredentialsProvider from "next-auth/providers/credentials";
// import { authConfig } from "./auth.config";
// import bcrypt from "bcryptjs";
// import { db } from "./app/lib/db";
// import userModel from "./app/lib/userModel";

// const login = async (credentials: any) => {
//   try {
//     await db();
//     console.log("database connected");
//     const user = await userModel.findOne({ email: credentials.email });
//     console.log(user);

//     if (!user) throw new Error("Wrong credentials!");

//     const isPasswordCorrect = await bcrypt.compare(
//       credentials.password,
//       user.password
//     );

//     if (!isPasswordCorrect) throw new Error("Wrong credentials!");

//     return user;
//   } catch (err) {
//     console.log(err);
//     throw new Error("Failed to login!");
//   }
// };

// export const { signIn, signOut, auth } = NextAuth({
//   ...authConfig,
//   providers: [
//     CredentialsProvider({
//       async authorize(credentials) {
//         try {
//           const user = await login(credentials);
//           return user;
//         } catch (err) {
//           console.log(err);
//           return null;
//         }
//       },
//     }),
//   ],
//   // ADD ADDITIONAL INFORMATION TO SESSION
//   //   callbacks: {
//   //     async jwt({ token, user }) {
//   //       if (user) {
//   //         token.username = user.username;
//   //         token.img = user.img;
//   //       }
//   //       return token;
//   //     },
//   //     async session({ session, token }) {
//   //       if (token) {
//   //         session.user.username = token.username;
//   //         session.user.img = token.img;
//   //       }
//   //       return session;
//   //     },
//   //   },
// });
