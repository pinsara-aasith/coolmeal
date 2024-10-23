"use client";
import { useState } from "react";
import axios from "axios";
import { FaRobot, FaCheckCircle } from "react-icons/fa"; // Import icons for progress and success

const UploadPdfPage = () => {
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [uploadStatus, setUploadStatus] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(false); // Loading state

  // Handle file input change
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0] || null;
    setSelectedFile(file);
  };

  // Handle form submit
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!selectedFile) {
      setError("Please select a PDF file to upload.");
      return;
    }

    // Reset status and error
    setUploadStatus(null);
    setError(null);
    setIsLoading(true); // Set loading state to true

    const formData = new FormData();
    formData.append("file", selectedFile);

    try {
      const response = await axios.post("/api/pdf", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      if (response.status === 200) {
        setUploadStatus("File uploaded successfully");
      }
    } catch (err) {
      setError("Failed to upload file. Please try again.");
    } finally {
      setIsLoading(false); // Reset loading state
    }
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-green-100">
      <style jsx>{`
        @keyframes blink {
          50% {
            opacity: 0;
          }
        }

        .animate-blink {
          animation: blink 1s linear infinite;
        }
      `}</style>

      {/* Page Header */}
      <div className="text-center mb-8">
        <h1 className="text-3xl font-bold text-gray-700">
          Upload PDF files to Train Food Related Chatbot
        </h1>
        <p className="mt-2 text-lg text-gray-600">
          Upload training data in PDF format to improve chatbot accuracy.
        </p>
      </div>

      <div className="w-full max-w-md p-8 space-y-6 bg-white rounded-lg shadow-lg">
        {/* Conditionally render the form, progress, or success message */}
        {uploadStatus ? (
          // Success message with checkmark icon
          <div className="flex flex-col items-center justify-center">
            <FaCheckCircle className="text-green-600 h-16 w-16" />
            <h2 className="text-center text-2xl font-bold text-green-600 mt-4">
              Pdf Uploaded and Chat Bot Training Successfully!
            </h2>
          </div>
        ) : isLoading ? (
          // Progress indicator with blinking animation
          <div className="flex flex-col items-center justify-center">
            <h2 className="text-center text-2xl font-bold text-indigo-600 animate-blink">
              Training Chat Bot...
            </h2>
            <FaRobot className="mt-4 h-16 w-16 text-indigo-600" />
            <div className="flex justify-center mt-4">
              <svg
                className="animate-spin h-10 w-10 text-indigo-600"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  className="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  strokeWidth="4"
                ></circle>
                <path
                  className="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8v8H4z"
                ></path>
              </svg>
            </div>
          </div>
        ) : (
          <>
            <h2 className="text-center text-2xl font-bold text-gray-700">
              Upload PDF
            </h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700">
                  Select a PDF file:
                </label>
                <input
                  type="file"
                  accept="application/pdf"
                  onChange={handleFileChange}
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                />
              </div>

              {error && <p className="text-red-500 text-sm">{error}</p>}

              <div>
                <button
                  type="submit"
                  className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  Upload PDF
                </button>
              </div>
            </form>
          </>
        )}
      </div>
    </div>
  );
};

export default UploadPdfPage;
