"use client";
import useToast from "@/hooks/use-snackbar";
import { CredentialsLoginData, credentialLogin } from "@/lib/auth";
import { Card } from "@radix-ui/themes";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useForm } from "react-hook-form";
export default function AdminLogin() {
  const [loading, setLoading] = useState(false);

  const toast = useToast();
  const router = useRouter();

  const onSubmit = async (loginData: CredentialsLoginData) => {
    try {
      const response = await credentialLogin(loginData);

      if (!!response.error) {
        console.error(response.error);
        toast.showSnackbarError(response.error.message);
      } else {
        setLoading(true);
        toast.showSnackbarSuccess("Login successful!");
        router.push("/dashboard");
      }
    } catch (e) {
      console.error(e);
      toast.showSnackbarError("Check your Credentials");
    }
  };

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<CredentialsLoginData>();

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100 ">
      <Card className="w-full max-w-sm bg-white shadow-lg ">
        <form
          className="space-y-6 p-5"
          noValidate
          autoComplete="off"
          onSubmit={handleSubmit(onSubmit)}
        >
          {!!errors.email && (
            <div className="text-red-500 text-sm">{!!errors.email}</div>
          )}
          <div>
            <Image
              className="mb-8"
              src="/Logo.png"
              width={500}
              height={500}
              alt="Picture of the author"
            />
            <label
              htmlFor="email"
              className="block text-sm font-medium leading-6 text-gray-900"
            >
              Email address
            </label>
            <div className="mt-2">
              <input
                id="email"
                type="email"
                autoComplete="email"
                {...register("email", {
                  required: "Email is required",
                })}
                // onChange={(e) => setEmail(e.target.value)}
                required
                className="px-3 block w-full rounded-md border-0 py-1.5 bg-gray-200 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div>
            <div className="flex items-center justify-between">
              <label
                htmlFor="password"
                className="block text-sm font-medium leading-6 text-gray-900"
              >
                Password
              </label>
              <div className="text-sm">
                <a
                  href="#"
                  className="font-semibold text-indigo-600 hover:text-indigo-500"
                >
                  Forgot password?
                </a>
              </div>
            </div>

            {!!errors.password && (
              <div className="text-red-500 text-sm">{!!errors.password}</div>
            )}
            <div className="mt-2">
              <input
                id="password"
                type="password"
                {...register("password", {
                  required: "Password is required",
                })}
                autoComplete="current-password"
                // onChange={(e) => setPassword(e.target.value)}
                required
                className="px-3 block w-full rounded-md border-0 py-1.5 bg-gray-200 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div>
            <button
              type="submit"
              disabled={loading}
              className={`flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 ${
                loading ? "opacity-50 cursor-not-allowed" : ""
              }`}
            >
              {loading ? "Logging in..." : "Login"}
            </button>
          </div>
        </form>
      </Card>
    </div>
  );
}
