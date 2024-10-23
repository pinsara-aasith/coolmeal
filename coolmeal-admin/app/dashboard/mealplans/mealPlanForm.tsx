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
  const [mealIndex, setMealIndex] = useState<any>(null);
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
      "Vitamin D(µg)": null,
      "Vitamin K(µg)": null,
      "Vitamin E(mg)": null,
      "Calcium(mg)": null,
      "Phosphorus(mg)": null,
      "Magnesium(mg)": null,
      "Sodium(mg)": null,
      "Potassium(mg)": null,
      "Saturated Fatty Acids(mg)": null,
      "Monounsaturated Fatty Acids(mg)": null,
      "Polyunsaturated Fatty Acids(mg)": null,
      "Free sugar(g)": null,
      "Starch(g)": null,
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
      "Vitamin D(µg)": null,
      "Vitamin K(µg)": null,
      "Vitamin E(mg)": null,
      "Calcium(mg)": null,
      "Phosphorus(mg)": null,
      "Magnesium(mg)": null,
      "Sodium(mg)": null,
      "Potassium(mg)": null,
      "Saturated Fatty Acids(mg)": null,
      "Monounsaturated Fatty Acids(mg)": null,
      "Polyunsaturated Fatty Acids(mg)": null,
      "Free sugar(g)": null,
      "Starch(g)": null,
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
      "Vitamin D(µg)": null,
      "Vitamin K(µg)": null,
      "Vitamin E(mg)": null,
      "Calcium(mg)": null,
      "Phosphorus(mg)": null,
      "Magnesium(mg)": null,
      "Sodium(mg)": null,
      "Potassium(mg)": null,
      "Saturated Fatty Acids(mg)": null,
      "Monounsaturated Fatty Acids(mg)": null,
      "Polyunsaturated Fatty Acids(mg)": null,
      "Free sugar(g)": null,
      "Starch(g)": null,
    },
    price: {
      Breakfast_Price: null,
      Lunch_Price: null,
      Dinner_Price: null,
    },
  });

  useEffect(() => {
    if (params?.id) {
      const fetchMealPlan = async () => {
        try {
          const response = await axios.get(`/api/mealplans/index`);
          setMealIndex(response.data);
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
    // update prices
    if (
      name === "Breakfast_Price" ||
      name === "Lunch_Price" ||
      name === "Dinner_Price"
    ) {
      setMealsData((prevData) => ({
        ...prevData,
        price: {
          ...prevData.price,
          [name]: value,
        },
      }));
      return;
    }

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

    const totalCarbohydrates =
      Number(mealsData.Breakfast["Carbohydrates(g)"]) +
      Number(mealsData.Lunch["Carbohydrates(g)"]) +
      Number(mealsData.Dinner["Carbohydrates(g)"]);

    const totalMagnesium =
      Number(mealsData.Breakfast["Magnesium(mg)"]) +
      Number(mealsData.Lunch["Magnesium(mg)"]) +
      Number(mealsData.Dinner["Magnesium(mg)"]);

    const totalSodium =
      Number(mealsData.Breakfast["Sodium(mg)"]) +
      Number(mealsData.Lunch["Sodium(mg)"]) +
      Number(mealsData.Dinner["Sodium(mg)"]);

    const totalPotassium =
      Number(mealsData.Breakfast["Potassium(mg)"]) +
      Number(mealsData.Lunch["Potassium(mg)"]) +
      Number(mealsData.Dinner["Potassium(mg)"]);

    const totalSaturatedFattyAcids =
      Number(mealsData.Breakfast["Saturated Fatty Acids(mg)"]) +
      Number(mealsData.Lunch["Saturated Fatty Acids(mg)"]) +
      Number(mealsData.Dinner["Saturated Fatty Acids(mg)"]);

    const totalMonounsaturatedFattyAcids =
      Number(mealsData.Breakfast["Monounsaturated Fatty Acids(mg)"]) +
      Number(mealsData.Lunch["Monounsaturated Fatty Acids(mg)"]) +
      Number(mealsData.Dinner["Monounsaturated Fatty Acids(mg)"]);

    const totalPolyunsaturatedFattyAcids =
      Number(mealsData.Breakfast["Polyunsaturated Fatty Acids(mg)"]) +
      Number(mealsData.Lunch["Polyunsaturated Fatty Acids(mg)"]) +
      Number(mealsData.Dinner["Polyunsaturated Fatty Acids(mg)"]);

    const totalFreeSugar =
      Number(mealsData.Breakfast["Free sugar(g)"]) +
      Number(mealsData.Lunch["Free sugar(g)"]) +
      Number(mealsData.Dinner["Free sugar(g)"]);

    const totalStarch =
      Number(mealsData.Breakfast["Starch(g)"]) +
      Number(mealsData.Lunch["Starch(g)"]) +
      Number(mealsData.Dinner["Starch(g)"]);

    const total_price =
      Number(mealsData.price["Breakfast_Price"]) +
      Number(mealsData.price["Lunch_Price"]) +
      Number(mealsData.price["Dinner_Price"]);

    const modelData = {
      Breakfast: breakfastCompleteMeal,
      Lunch: lunchCompleteMeal,
      Dinner: dinnerCompleteMeal,
      Price: total_price, // Add price logic if needed
      "Total Energy(Kcal)": totalEnergy,
      "Total Protein(g)": totalProtein,
      "Total fat(g)": totalFat,
      "Total Carbohydrates(g)": totalCarbohydrates,
      "Total Magnesium(mg)": totalMagnesium,
      "Total Sodium(mg)": totalSodium,
      "Total Potassium(mg)": totalPotassium,
      "Total Saturated Fatty Acids(mg)": totalSaturatedFattyAcids,
      "Total Monounsaturated Fatty Acids(mg)": totalMonounsaturatedFattyAcids,
      "Total Polyunsaturated Fatty Acids(mg)": totalPolyunsaturatedFattyAcids,
      "Total Free sugar(g)": totalFreeSugar,
      "Total Starch(g)": totalStarch,
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
              label="Breakfast Probability"
              name="Breakfast_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter breakfast probability"
            />
            <FormTextField
              label="Lunch Probability"
              name="Lunch_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter lunch probability"
            />
            <FormTextField
              label="Dinner Probability"
              name="Dinner_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter dinner probability"
            />
            <FormTextField
              label="Combined Meal"
              name="Combined_Meal"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter combined meal count"
            />
            <FormTextField
              label="Ingredients"
              name="Ingredients"
              onChange={handleInputChange}
              placeholder="Enter ingredients"
            />
            <FormTextField
              label="Quantities"
              name="Quantities"
              onChange={handleInputChange}
              placeholder="Enter quantities"
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
            <FormTextField
              label="Total Fat (g)"
              name="Breakfast_Total_fat(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter total fat amount"
            />
            <FormTextField
              label="Carbohydrates (g)"
              name="Breakfast_Carbohydrates(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter carbohydrates amount"
            />
            <FormTextField
              label="Total Dietary Fibre (g)"
              name="Breakfast_Total_Dietary_Fibre(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter dietary fiber amount"
            />
            <FormTextField
              label="Vitamin A (µg)"
              name="Breakfast_Vitamin_A(µg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter Vitamin A amount"
            />
            <FormTextField
              label="Vitamin D (µg)"
              name="Breakfast_Vitamin_D(µg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter Vitamin D amount"
            />
            <FormTextField
              label="Vitamin K (µg)"
              name="Breakfast_Vitamin_K(µg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter Vitamin K amount"
            />
            <FormTextField
              label="Vitamin E (mg)"
              name="Breakfast_Vitamin_E(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter Vitamin E amount"
            />
            <FormTextField
              label="Calcium (mg)"
              name="Breakfast_Calcium(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter calcium amount"
            />
            <FormTextField
              label="Phosphorus (mg)"
              name="Breakfast_Phosphorus(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter phosphorus amount"
            />
            <FormTextField
              label="Magnesium (mg)"
              name="Breakfast_Magnesium(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter magnesium amount"
            />
            <FormTextField
              label="Sodium (mg)"
              name="Breakfast_Sodium(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter sodium amount"
            />
            <FormTextField
              label="Potassium (mg)"
              name="Breakfast_Potassium(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter potassium amount"
            />
            <FormTextField
              label="Saturated Fatty Acids (mg)"
              name="Breakfast_Saturated_Fatty_Acids(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter saturated fatty acids amount"
            />
            <FormTextField
              label="Monounsaturated Fatty Acids (mg)"
              name="Breakfast_Monounsaturated_Fatty_Acids(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter monounsaturated fatty acids amount"
            />
            <FormTextField
              label="Polyunsaturated Fatty Acids (mg)"
              name="Breakfast_Polyunsaturated_Fatty_Acids(mg)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter polyunsaturated fatty acids amount"
            />
            <FormTextField
              label="Free Sugar (g)"
              name="Breakfast_Free_sugar(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter free sugar amount"
            />
            <FormTextField
              label="Starch (g)"
              name="Breakfast_Starch(g)"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter starch amount"
            />
            <FormTextField
              label="Price"
              name="Breakfast_Price"
              type="number"
              placeholder="Enter price"
              onChange={handleInputChange}
            />
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
            <FormTextField
              label="Total fat (g)"
              name="Lunch_Total_fat(g)"
              type="number"
              placeholder="Enter total fat amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Carbohydrates (g)"
              name="Lunch_Carbohydrates(g)"
              type="number"
              placeholder="Enter carbohydrates amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Total Dietary Fibre (g)"
              name="Lunch_Total_Dietary_Fibre(g)"
              type="number"
              placeholder="Enter dietary fibre amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin A (µg)"
              name="Lunch_Vitamin_A(µg)"
              type="number"
              placeholder="Enter vitamin A amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin D (µg)"
              name="Lunch_Vitamin_D(µg)"
              type="number"
              placeholder="Enter vitamin D amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin K (µg)"
              name="Lunch_Vitamin_K(µg)"
              type="number"
              placeholder="Enter vitamin K amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin E (mg)"
              name="Lunch_Vitamin_E(mg)"
              type="number"
              placeholder="Enter vitamin E amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Calcium (mg)"
              name="Lunch_Calcium(mg)"
              type="number"
              placeholder="Enter calcium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Phosphorus (mg)"
              name="Lunch_Phosphorus(mg)"
              type="number"
              placeholder="Enter phosphorus amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Magnesium (mg)"
              name="Lunch_Magnesium(mg)"
              type="number"
              placeholder="Enter magnesium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Sodium (mg)"
              name="Lunch_Sodium(mg)"
              type="number"
              placeholder="Enter sodium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Potassium (mg)"
              name="Lunch_Potassium(mg)"
              type="number"
              placeholder="Enter potassium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Saturated Fatty Acids (mg)"
              name="Lunch_Saturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter saturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Monounsaturated Fatty Acids (mg)"
              name="Lunch_Monounsaturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter monounsaturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Polyunsaturated Fatty Acids (mg)"
              name="Lunch_Polyunsaturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter polyunsaturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Free sugar (g)"
              name="Lunch_Free_sugar(g)"
              type="number"
              placeholder="Enter free sugar amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Starch (g)"
              name="Lunch_Starch(g)"
              type="number"
              placeholder="Enter starch amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Price"
              name="Lunch_Price"
              type="number"
              placeholder="Enter price"
              onChange={handleInputChange}
            />
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
            <FormTextField
              label="Total fat (g)"
              name="Dinner_Total_fat(g)"
              type="number"
              placeholder="Enter total fat amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Carbohydrates (g)"
              name="Dinner_Carbohydrates(g)"
              type="number"
              placeholder="Enter carbohydrates amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Total Dietary Fibre (g)"
              name="Dinner_Total_Dietary_Fibre(g)"
              type="number"
              placeholder="Enter dietary fibre amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin A (µg)"
              name="Dinner_Vitamin_A(µg)"
              type="number"
              placeholder="Enter vitamin A amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin D (µg)"
              name="Dinner_Vitamin_D(µg)"
              type="number"
              placeholder="Enter vitamin D amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin K (µg)"
              name="Dinner_Vitamin_K(µg)"
              type="number"
              placeholder="Enter vitamin K amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Vitamin E (mg)"
              name="Dinner_Vitamin_E(mg)"
              type="number"
              placeholder="Enter vitamin E amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Calcium (mg)"
              name="Dinner_Calcium(mg)"
              type="number"
              placeholder="Enter calcium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Phosphorus (mg)"
              name="Dinner_Phosphorus(mg)"
              type="number"
              placeholder="Enter phosphorus amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Magnesium (mg)"
              name="Dinner_Magnesium(mg)"
              type="number"
              placeholder="Enter magnesium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Sodium (mg)"
              name="Dinner_Sodium(mg)"
              type="number"
              placeholder="Enter sodium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Potassium (mg)"
              name="Dinner_Potassium(mg)"
              type="number"
              placeholder="Enter potassium amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Saturated Fatty Acids (mg)"
              name="Dinner_Saturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter saturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Monounsaturated Fatty Acids (mg)"
              name="Dinner_Monounsaturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter monounsaturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Polyunsaturated Fatty Acids (mg)"
              name="Dinner_Polyunsaturated_Fatty_Acids(mg)"
              type="number"
              placeholder="Enter polyunsaturated fatty acids amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Free sugar (g)"
              name="Dinner_Free_sugar(g)"
              type="number"
              placeholder="Enter free sugar amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Starch (g)"
              name="Dinner_Starch(g)"
              type="number"
              placeholder="Enter starch amount"
              onChange={handleInputChange}
            />
            <FormTextField
              label="Price"
              name="Dinner_Price"
              type="number"
              placeholder="Enter price"
              onChange={handleInputChange}
            />
          </Grid>
          <button
            type="button"
            className="mt-4 inline-flex h-[35px] items-center justify-center rounded bg-blue-500 text-white px-4"
            onClick={handleSave}
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
