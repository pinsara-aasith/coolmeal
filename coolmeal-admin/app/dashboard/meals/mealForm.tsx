"use client";

import CustomButton from "@/component/CustomButton";
import {
  FormCheckboxField,
  FormSelectField,
  FormTextAreaField,
  FormTextField,
} from "@/component/Forms";
import * as Form from "@radix-ui/react-form";
import { Grid } from "@radix-ui/themes";
import axios from "axios";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";

interface Props {
  params?: {
    id: string;
  };
}

const MealForm = ({ params }: Props) => {
  const [meal, setMeal] = useState<any>(null);
  const router = useRouter();

  useEffect(() => {
    // Fetch meal item data if editing (params.id exists)
    if (params?.id) {
      const fetchMeal = async () => {
        try {
          const response = await axios.get(
            `/api/dashboard/meal-items/${params.id}`
          );
          setMeal(response.data);
        } catch (error) {
          console.error("Error fetching meal item details: ", error);
        }
      };
      fetchMeal();
    }
  }, [params?.id]);

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    // const formData = new FormData(event.currentTarget);
    // const data = Object.fromEntries(formData.entries());

    // try {
    //   if (params?.id) {
    //     await axios.patch(`/api/dashboard/mealitems/${params.id}`, data);
    //   } else {
    //     await axios.post("/api/dashboard/mealitems", data);
    //   }
    //   router.push("/dashboard/meal-items");
    // } catch (error) {
    //   console.error("Error submitting form: ", error);
    // }
  };

  return (
    <Form.Root onSubmit={handleSubmit}>
      <FormTextField
        label="Meal Name"
        name="Name"
        placeholder="Enter meal name"
      />

      <FormSelectField
        label="Category"
        name="Category"
        required={true}
        options={[
          { value: "Side", label: "Side" },
          { value: "Main", label: "Main" },
        ]}
      />

      <FormTextAreaField
        label="Description"
        name="description"
        placeholder="Enter description"
      />

      <FormTextField
        label="Supported Main Meals"
        name="supported-main-meals"
        placeholder="Enter supported main meals"
      />

      <FormCheckboxField
        label="Combinations Supported"
        name="Combinations_Supported"
        defaultChecked={true}
        required={true}
      />

      <Grid columns="3" gap="12px" width="auto">
        <FormTextField
          label="Morning Preference Out Of 10"
          name="morning-probability"
          type="number"
          placeholder="Enter morning probability"
        />

        <FormTextField
          label="Lunch Preference Out Of 10"
          name="Lunch_Probability"
          type="number"
          placeholder="Enter lunch probability"
        />

        <FormTextField
          label="Dinner Preference Out Of 10"
          name="Lunch_Probability"
          type="number"
          placeholder="Enter dinner probability"
        />
      </Grid>

      <Grid columns="2" gap="12px" width="auto">
        <FormTextField
          label="Max Combinations"
          name="max-combinations"
          type="number"
          placeholder="Enter max combinations"
        />

        <FormTextField
          label="Min Combinations"
          name="min-combinations"
          type="number"
          placeholder="Enter min combinations"
        />
      </Grid>

      <FormTextField
        label="Ingredient IDs"
        name="ingredient-ids"
        placeholder="Enter ingredient IDs"
      />

      <CustomButton />
      <div className="mt-[25px] flex justify-end">
        <button className="inline-flex h-[35px] items-center justify-center rounded bg-green4 px-[15px] font-medium leading-none text-green11 hover:bg-green5 focus:shadow-[0_0_0_2px] focus:shadow-green7 focus:outline-none">
          Save changes
        </button>
      </div>
    </Form.Root>
  );
};

export default MealForm;
