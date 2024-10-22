
'use server'

import { signIn, signOut } from "./authOptions";
export interface CredentialsLoginData { email: string, password: string }


export async function logout() {
  await signOut({ redirectTo: "/login" });
}

export async function credentialLogin(loginData: CredentialsLoginData) {

  try {
    const response = await signIn("credentials", {
      email: loginData.email,
      password: loginData.password,
      redirect: false,
    });
    return response;
  } catch (err) {
    throw err;
  }
}