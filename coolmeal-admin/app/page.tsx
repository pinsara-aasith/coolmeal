"use client";

import { useState } from "react";
import axios from "axios";
import * as Form from "@radix-ui/react-form";
import FormFieldSlider, { FormTextField } from "@/component/Forms";
import { useRouter } from "next/navigation";
import { Card } from "@radix-ui/themes";
import Image from "next/image";

import logoPng from "@/public/newlogo.png";
import loginBgJpg from "@/public/loginbg.jpg";

const PredictionForm = ({ params }: { params: any }) => {
  const [predictionData, setPredictionData] = useState<any>(null);
  const router = useRouter();

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const data = Object.fromEntries(formData.entries());

    try {
      if (params?.id) {
        await axios.patch(`/api/predictions/${params.id}`, data);
      } else {
        await axios.post("/api/predictions", data);
      }
      router.push("/predictions");
    } catch (error) {
      console.error("Error submitting form: ", error);
    }
  };

  return (
    <Form.Root onSubmit={handleSubmit}>
      <FormTextField
        label="Age"
        name="age"
        type="number"
        placeholder="Enter age"
      />

      <FormTextField
        label="Weight (kg)"
        name="weight"
        type="number"
        placeholder="Enter weight"
      />

      <FormTextField
        label="Height (cm)"
        name="height"
        type="number"
        placeholder="Enter height"
      />

      <FormFieldSlider
        label="Diabetes Level"
        name="diabetesLevel"
        min={0}
        max={10}
        step={1}
        defaultValue={5}
      />

      <FormFieldSlider
        label="Pressure Level"
        name="pressureLevel"
        min={0}
        max={10}
        step={1}
        defaultValue={5}
      />

      <FormFieldSlider
        label="Cholesterol Level"
        name="cholesterolLevel"
        min={0}
        max={10}
        step={1}
        defaultValue={5}
      />

      <FormFieldSlider
        label="Activity Level"
        name="activityLevel"
        min={0}
        max={10}
        step={1}
        defaultValue={5}
      />

      <div className="mt-[25px] flex justify-end">
        <button className="inline-flex h-[35px] items-center justify-center rounded bg-green4 px-[15px] font-medium leading-none text-green11 hover:bg-green5 focus:shadow-[0_0_0_2px] focus:shadow-green7 focus:outline-none">
          Get Your Customized Meal Plan
        </button>
      </div>
    </Form.Root>
  );
};

const PredictionPage: React.FC<any> = ({ params }) => {
  return (
    <div
      className="flex items-center justify-center min-h-screen bg-gray-100"
      style={{
        backgroundImage: `url(${loginBgJpg.src})`,
        backgroundSize: "cover",
      }}
    >
      <div className="w-full max-w-lg bg-white shadow-lg px-16 overflow-scroll max-h-fit py-10">
        <div className="flex items-center justify-between flex-col">
          <Image
            className="mb-8"
            src={logoPng}
            width={120}
            height={120}
            alt="Picture"
          />
        </div>

        <PredictionForm params={params} />
      </div>
    </div>
  );
};

export default PredictionPage;
