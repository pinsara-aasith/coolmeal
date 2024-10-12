import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";

const firebaseConfig = {
  apiKey: "AIzaSyAxpdHIReAuPKnix7The9KXjzTeIgGPIZ8",
  authDomain: "coolmeal-app.firebaseapp.com",
  projectId: "coolmeal-app",
  storageBucket: "coolmeal-app.appspot.com",
  messagingSenderId: "632689501425",
  appId: "1:632689501425:web:db4712a434c9b63422f550",
  measurementId: "G-Y7K3FZE6BE",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

export const db = getFirestore();
export const storage = getStorage();
