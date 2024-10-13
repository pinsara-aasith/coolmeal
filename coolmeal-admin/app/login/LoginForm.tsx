"use client";
import { Card } from "@radix-ui/themes";
import { useState } from "react";
import axios from "axios";
// import { authenticate } from "../lib/actions";

export default function AdminLogin() {
  // const [email, setEmail] = useState("");
  // const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  // const handleSubmit = async (e: React.FormEvent) => {
  //   e.preventDefault();
  //   setLoading(true);
  //   setError(""); // Clear any previous errors

  //   try {
  //     const res = await axios.post("/api/auth/login", {
  //       email,
  //       password,
  //     });

  //     const { token } = res.data;

  //     // Store the token in localStorage (or cookies) for future use
  //     localStorage.setItem("token", token);

  //     // Redirect to the admin dashboard or another page
  //     window.location.href = "/dashboard";
  //   } catch (error: any) {
  //     console.error("Error logging in:", error);
  //     setError(
  //       error.response?.data?.message || "An error occurred. Please try again."
  //     );
  //   } finally {
  //     setLoading(false);
  //   }
  // };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100 ">
      <Card className="w-full max-w-sm bg-white shadow-lg ">
        <form
          className="space-y-6 p-5"
          // action={authenticate}
          method="POST"
          // onSubmit={handleSubmit}
        >
          {error && <div className="text-red-500 text-sm">{error}</div>}
          <div>
            <label
              htmlFor="email"
              className="block text-sm font-medium leading-6 text-gray-900"
            >
              Email address
            </label>
            <div className="mt-2">
              <input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                // onChange={(e) => setEmail(e.target.value)}
                required
                className="block w-full rounded-md border-0 py-1.5 bg-gray-200 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
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
            <div className="mt-2">
              <input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                // onChange={(e) => setPassword(e.target.value)}
                required
                className="block w-full rounded-md border-0 py-1.5 bg-gray-200 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
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
