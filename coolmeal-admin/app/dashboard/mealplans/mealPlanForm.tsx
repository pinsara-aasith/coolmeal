"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import axios from "axios";
import { Button, Grid } from "@radix-ui/themes";
import CustomButton from "@/component/CustomButton";
import * as Form from "@radix-ui/react-form";
import { FormTextField, FormTextAreaField } from "@/component/Forms";
import { HiCheckCircle } from "react-icons/hi"; // Import an icon for success notification

interface Props {
  params?: {
    id?: string;
  };
}

const MealPlanForm = ({ params }: Props) => {
  const [mealPlan, setMealPlan] = useState<any>(null);
  const router = useRouter();

  // State to manage which section is currently visible
  const [currentSection, setCurrentSection] = useState(0); // 0: Breakfast, 1: Lunch, 2: Dinner
  // State for notifications
  const [notifications, setNotifications] = useState<string[]>([]); // Track completed sections

  const [mealsData, setMealsData] = useState({
    Breakfast: {
      Breakfast_Main_Meal: "",
      Breakfast_Side_Meal: "",
      Breakfast_Complete_Meal: "",
      Ingredients: "",
      Quantities: "",
      "Breakfast_Energy(Kcal)": 0,
      "Breakfast_Protein(g)": 0,
      "Total fat(g)": 0,
      "Carbohydrates(g)": 0,
      "Total Dietary Fibre(g)": null,
      "Vitamin A(µg)": null,
    },
    Lunch: {
      Lunch_Main_Meal: "",
      Lunch_Side_Meal: "",
      Lunch_Complete_Meal: "",
      Ingredients: "",
      Quantities: "",
      "Lunch_Energy(Kcal)": 0,
      "Lunch_Protein(g)": 0,
      "Total fat(g)": 0,
      "Carbohydrates(g)": 0,
      "Total Dietary Fibre(g)": null,
      "Vitamin A(µg)": null,
    },
    Dinner: {
      Dinner_Main_Meal: "",
      Dinner_Side_Meal: "",
      Dinner_Complete_Meal: "",
      Ingredients: "",
      Quantities: "",
      "Dinner_Energy(Kcal)": 0,
      "Dinner_Protein(g)": 0,
      "Total fat(g)": 0,
      "Carbohydrates(g)": 0,
      "Total Dietary Fibre(g)": null,
      "Vitamin A(µg)": null,
    },
  });

  useEffect(() => {
    if (params?.id) {
      const fetchMealPlan = async () => {
        try {
          const response = await axios.get(
            `/api/dashboard/meal-items/${params.id}`
          );
          setMealPlan(response.data);
        } catch (error) {
          console.error("Error fetching meal item details: ", error);
        }
      };
      fetchMealPlan();
    }
  }, [params?.id]);

  // Handle real-time input changes
  const handleInputChange = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = event.target;

    const section =
      currentSection === 0
        ? "Breakfast"
        : currentSection === 1
        ? "Lunch"
        : "Dinner";

    setMealsData((prevData) => ({
      ...prevData,
      [section]: {
        ...prevData[section],
        [name]: value, // Update the specific field in the current meal section
      },
    }));
  };

  // / Handle form data submission and save to appropriate meal section
  const handleSave = (formData: any) => {
    const updatedNotifications = [...notifications];

    if (currentSection === 0 && !notifications.includes("Breakfast")) {
      updatedNotifications.push("Breakfast");

      console.log("Breakfast data: ", mealsData.Breakfast);
    } else if (currentSection === 1 && !notifications.includes("Lunch")) {
      updatedNotifications.push("Lunch");
      console.log("Lunch Data --");
    } else if (currentSection === 2 && !notifications.includes("Dinner")) {
      updatedNotifications.push("Dinner");
      console.log("Dinner data ", mealsData.Dinner);
    }

    setNotifications(updatedNotifications);

    if (currentSection < 2) {
      setCurrentSection(currentSection + 1); // Move to the next section
    }
  };

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    const breakfastCompleteMeal =
      mealsData.Breakfast["Breakfast_Complete_Meal"];
    const lunchCompleteMeal = mealsData.Lunch["Lunch_Complete_Meal"];
    const dinnerCompleteMeal = mealsData.Dinner["Dinner_Complete_Meal"];

    const totalEnergy =
      Number(mealsData.Breakfast["Breakfast_Energy(Kcal)"]) +
      Number(mealsData.Lunch["Lunch_Energy(Kcal)"]) +
      Number(mealsData.Dinner["Dinner_Energy(Kcal)"]);

    const totalProtein =
      Number(mealsData.Breakfast["Breakfast_Protein(g)"]) +
      Number(mealsData.Lunch["Lunch_Protein(g)"]) +
      Number(mealsData.Dinner["Dinner_Protein(g)"]);

    const totalFat =
      Number(mealsData.Breakfast["Total fat(g)"]) +
      Number(mealsData.Lunch["Total fat(g)"]) +
      Number(mealsData.Dinner["Total fat(g)"]);

    const totalCarbs =
      Number(mealsData.Breakfast["Carbohydrates(g)"]) +
      Number(mealsData.Lunch["Carbohydrates(g)"]) +
      Number(mealsData.Dinner["Carbohydrates(g)"]);

    const modelData = {
      Breakfast: breakfastCompleteMeal,
      Lunch: lunchCompleteMeal,
      Dinner: dinnerCompleteMeal,
      Price: 0, // Add price logic if needed
      "Total Energy(Kcal)": totalEnergy,
      "Total Protein(g)": totalProtein,
      "Total fat(g)": totalFat,
      "Total Carbohydrates(g)": totalCarbs,
      "Total Magnesium(mg)": 0,
      "Total Sodium(mg)": 0,
      "Total Potassium(mg)": 0,
      "Total Saturated Fatty Acids(mg)": 0,
      "Total Monounsaturated Fatty Acids(mg)": 0,
      "Total Polyunsaturated Fatty Acids(mg)": 0,
      "Total Free sugar(g)": 0,
      "Total Starch(g)": 0,
      index: 0,
    };

    try {
      console.log(
        "Breakfast data: ",
        mealsData.Breakfast["Breakfast_Complete_Meal"]
      );
      console.log("Lunch data: ", mealsData.Lunch["Lunch_Complete_Meal"]);
      console.log("Dinner data: ", mealsData.Dinner["Dinner_Complete_Meal"]);
      console.log("Model data: ", modelData);

      // router.push("/dashboard/meal-items");
    } catch (error) {
      console.error("Error submitting form: ", error);
    }
  };

  return (
    <Form.Root
      onSubmit={handleSubmit}
      className="overflow-scroll p-4 w-full max-w-screen-2xl mx-auto"
    >
      {/* Notifications */}
      {notifications.length > 0 && (
        <div className="bg-green-100 text-green-700 p-4 mb-4 rounded flex items-center">
          <HiCheckCircle className="w-5 h-5 mr-2" />
          <span>{notifications.join(", ")} added successfully!</span>
        </div>
      )}

      {/* Breakfast Section */}
      {currentSection === 0 && (
        <section className="mb-8">
          <h2 className="text-2xl font-bold mb-4">Breakfast</h2>
          <Grid columns="3" gap="12px">
            <FormTextField
              label="Main Meal"
              name="Breakfast_Main_Meal"
              placeholder="Enter breakfast main meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Side Meal"
              name="Breakfast_Side_Meal"
              placeholder="Enter breakfast side meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Complete Meal"
              name="Breakfast_Complete_Meal"
              placeholder="Enter breakfast complete meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Energy (Kcal)"
              name="Breakfast_Energy(Kcal)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter energy value"
            />
            <FormTextField
              label="Protein (g)"
              name="Breakfast_Protein(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter protein amount"
            />
            {/* Add other nutrient fields here for Breakfast */}
          </Grid>
          <button
            type="button"
            className="mt-4 inline-flex h-[35px] items-center justify-center rounded bg-blue-500 text-white px-4"
            onClick={handleSave}
          >
            Save Breakfast
          </button>
        </section>
      )}

      {/* Lunch Section */}
      {currentSection === 1 && (
        <section className="mb-8">
          <h2 className="text-2xl font-bold mb-4">Lunch</h2>
          <Grid columns="3" gap="12px">
            <FormTextField
              label="Main Meal"
              name="Lunch_Main_Meal"
              placeholder="Enter lunch main meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Side Meal"
              name="Lunch_Side_Meal"
              placeholder="Enter lunch side meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Complete Meal"
              name="Lunch_Complete_Meal"
              placeholder="Enter lunch complete meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Energy (Kcal)"
              name="Lunch_Energy(Kcal)"
              type="number"
              placeholder="Enter energy value"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Protein (g)"
              name="Lunch_Protein(g)"
              type="number"
              placeholder="Enter protein amount"
              onChange={handleInputChange}
            />
            {/* Add other nutrient fields here for Lunch */}
          </Grid>
          <button
            type="button"
            className="mt-4 inline-flex h-[35px] items-center justify-center rounded bg-blue-500 text-white px-4"
            onClick={handleSave}
          >
            Save Lunch
          </button>
        </section>
      )}

      {/* Dinner Section */}
      {currentSection === 2 && (
        <section className="mb-8">
          <h2 className="text-2xl font-bold mb-4">Dinner</h2>
          <Grid columns="3" gap="12px">
            <FormTextField
              label="Main Meal"
              name="Dinner_Main_Meal"
              placeholder="Enter dinner main meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Side Meal"
              name="Dinner_Side_Meal"
              placeholder="Enter dinner side meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Complete Meal"
              name="Dinner_Complete_Meal"
              placeholder="Enter dinner complete meal"
              onChange={handleInputChange}
              required
            />
            <FormTextField
              label="Energy (Kcal)"
              name="Dinner_Energy(Kcal)"
              type="number"
              placeholder="Enter energy value"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Protein (g)"
              name="Dinner_Protein(g)"
              type="number"
              placeholder="Enter protein amount"
              onChange={handleInputChange}
            />
            {/* Add other nutrient fields here for Dinner */}
          </Grid>
          <button
            type="button" // <--- Change this from "submit" to "button"
            className="mt-4 inline-flex h-[35px] items-center justify-center rounded bg-blue-500 text-white px-4"
            onClick={handleSave} // <--- Trigger the save function when clicked
          >
            Save Dinner
          </button>
        </section>
      )}

      {/* Train Model Button - Only visible when Dinner is completed */}
      {notifications.includes("Dinner") && (
        <div className="flex justify-center mt-8">
          <button className="inline-flex items-center justify-center bg-blue-500 text-white px-4 py-2 rounded">
            <span className="mr-2">Train Model</span>
          </button>
        </div>
      )}
    </Form.Root>
  );
};

export default MealPlanForm;
