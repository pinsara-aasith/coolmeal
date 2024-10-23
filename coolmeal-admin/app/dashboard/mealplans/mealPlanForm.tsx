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
      Breakfast_Breakfast_Probability: 0,
      Breakfast_Lunch_Probability: 0,
      Breakfast_Dinner_Probability: 0,
      Breakfast_Ingredients: "",
      Breakfast_Quantities: "",
      Breakfast_Combined_Meal: 0,
      "Breakfast_Energy(Kcal)": 0,
      "Breakfast_Protein(g)": 0,
      "Breakfast_Total_fat(g)": 0,
      "Breakfast_Carbohydrates(g)": 0,
      "Breakfast_Total_Dietary_Fibre(g)": 0,
      "Breakfast_Vitamin_A(µg)": 0,
      "Breakfast_Vitamin_D(µg)": 0,
      "Breakfast_Vitamin_K(µg)": 0,
      "Breakfast_Vitamin_E(mg)": 0,
      "Breakfast_Calcium(mg)": 0,
      "Breakfast_Phosphorus(mg)": 0,
      "Breakfast_Magnesium(mg)": 0,
      "Breakfast_Sodium(mg)": 0,
      "Breakfast_Potassium(mg)": 0,
      "Breakfast_Saturated_Fatty_Acids(mg)": 0,
      "Breakfast_Monounsaturated_Fatty_Acids(mg)": 0,
      "Breakfast_Polyunsaturated_Fatty_Acids(mg)": 0,
      "Breakfast_Free_sugar(g)": 0,
      "Breakfast_Starch(g)": 0,
    },
    Lunch: {
      Lunch_Main_Meal: "",
      Lunch_Side_Meal: "",
      Lunch_Complete_Meal: "",
      Lunch_Ingredients: "",
      Lunch_Quantities: "",
      "Lunch_Energy(Kcal)": 0,
      "Lunch_Protein(g)": 0,
      "Lunch_Total_fat(g)": 0,
      "Lunch_Carbohydrates(g)": 0,
      "Lunch_Total_Dietary_Fibre(g)": 0,
      "Lunch_Vitamin_A(µg)": 0,
      "Lunch_Vitamin_D(µg)": 0,
      "Lunch_Vitamin_K(µg)": 0,
      "Lunch_Vitamin_E(mg)": 0,
      "Lunch_Calcium(mg)": 0,
      "Lunch_Phosphorus(mg)": 0,
      "Lunch_Magnesium(mg)": 0,
      "Lunch_Sodium(mg)": 0,
      "Lunch_Potassium(mg)": 0,
      "Lunch_Saturated_Fatty_Acids(mg)": 0,
      "Lunch_Monounsaturated_Fatty_Acids(mg)": 0,
      "Lunch_Polyunsaturated_Fatty_Acids(mg)": 0,
      "Lunch_Free_sugar(g)": 0,
      "Lunch_Starch(g)": 0,
    },
    Dinner: {
      Dinner_Main_Meal: "",
      Dinner_Side_Meal: "",
      Dinner_Complete_Meal: "",
      Dinner_Ingredients: "",
      Dinner_Quantities: "",
      "Dinner_Energy(Kcal)": 0,
      "Dinner_Protein(g)": 0,
      "Dinner_Total_fat(g)": 0,
      "Dinner_Carbohydrates(g)": 0,
      "Dinner_Total_Dietary_Fibre(g)": 0,
      "Dinner_Vitamin_A(µg)": 0,
      "Dinner_Vitamin_D(µg)": 0,
      "Dinner_Vitamin_K(µg)": 0,
      "Dinner_Vitamin_E(mg)": 0,
      "Dinner_Calcium(mg)": 0,
      "Dinner_Phosphorus(mg)": 0,
      "Dinner_Magnesium(mg)": 0,
      "Dinner_Sodium(mg)": 0,
      "Dinner_Potassium(mg)": 0,
      "Dinner_Saturated_Fatty_Acids(mg)": 0,
      "Dinner_Monounsaturated_Fatty_Acids(mg)": 0,
      "Dinner_Polyunsaturated_Fatty_Acids(mg)": 0,
      "Dinner_Free_sugar(g)": 0,
      "Dinner_Starch(g)": 0,
    },
    price: {
      Breakfast_Price: 0,
      Lunch_Price: 0,
      Dinner_Price: 0,
    },
  });

  const mapBreakfastMealDataToRequestBody = (mealData: any) => {
    return {
      "Main Meal": mealData.Breakfast.Breakfast_Main_Meal,
      "Side Meal": mealData.Breakfast.Breakfast_Side_Meal,
      "Complete Meal": mealData.Breakfast.Breakfast_Complete_Meal,
      Breakfast_Probability: mealData.Breakfast.Breakfast_Breakfast_Probability,
      Lunch_Probability: mealData.Breakfast.Breakfast_Lunch_Probability,
      Dinner_Probability: mealData.Breakfast.Breakfast_Dinner_Probability,
      Combined_Meal: mealData.Breakfast.Breakfast_Combined_Meal,
      Ingredients: mealData.Breakfast.Breakfast_Ingredients,
      Quantities: mealData.Breakfast.Breakfast_Quantities,
      "Energy(Kcal)": mealData.Breakfast["Breakfast_Energy(Kcal)"],
      "Protein(g)": mealData.Breakfast["Breakfast_Protein(g)"],
      "Total fat(g)": mealData.Breakfast["Breakfast_Total_fat(g)"],
      "Carbohydrates(g)": mealData.Breakfast["Breakfast_Carbohydrates(g)"],
      "Total Dietary Fibre(g)":
        mealData.Breakfast["Breakfast_Total_Dietary_Fibre(g)"],
      "Vitamin A(µg)": mealData.Breakfast["Breakfast_Vitamin_A(µg)"],
      "Vitamin D(µg)": mealData.Breakfast["Breakfast_Vitamin_D(µg)"],
      "Vitamin K(µg)": mealData.Breakfast["Breakfast_Vitamin_K(µg)"],
      "Vitamin E(mg)": mealData.Breakfast["Breakfast_Vitamin_E(mg)"],
      "Calcium(mg)": mealData.Breakfast["Breakfast_Calcium(mg)"],
      "Phosphorus(mg)": mealData.Breakfast["Breakfast_Phosphorus(mg)"],
      "Magnesium(mg)": mealData.Breakfast["Breakfast_Magnesium(mg)"],
      "Sodium(mg)": mealData.Breakfast["Breakfast_Sodium(mg)"],
      "Potassium(mg)": mealData.Breakfast["Breakfast_Potassium(mg)"],
      "Saturated Fatty Acids(mg)":
        mealData.Breakfast["Breakfast_Saturated_Fatty_Acids(mg)"],
      "Monounsaturated Fatty Acids(mg)":
        mealData.Breakfast["Breakfast_Monounsaturated_Fatty_Acids(mg)"],
      "Polyunsaturated Fatty Acids(mg)":
        mealData.Breakfast["Breakfast_Polyunsaturated_Fatty_Acids(mg)"],
      "Free sugar(g)": mealData.Breakfast["Breakfast_Free_sugar(g)"],
      "Starch(g)": mealData.Breakfast["Breakfast_Starch(g)"],
    };
  };

  const mapLunchMealDataToRequestBody = (mealData: any) => {
    return {
      "Main Meal": mealData.Lunch.Lunch_Main_Meal,
      "Side Meal": mealData.Lunch.Lunch_Side_Meal,
      "Complete Meal": mealData.Lunch.Lunch_Complete_Meal,
      Breakfast_Probability: mealData.Lunch.Lunch_Breakfast_Probability, // Assuming this is meant to map the Breakfast probability for lunch
      Lunch_Probability: mealData.Lunch.Lunch_Lunch_Probability, // Add probability if required
      Dinner_Probability: mealData.Lunch.Lunch_Dinner_Probability, // Add probability if required
      Combined_Meal: mealData.Lunch.Lunch_Combined_Meal, // If there's a Combined_Meal field for lunch
      Ingredients: mealData.Lunch.Lunch_Ingredients,
      Quantities: mealData.Lunch.Lunch_Quantities,
      "Energy(Kcal)": mealData.Lunch["Lunch_Energy(Kcal)"],
      "Protein(g)": mealData.Lunch["Lunch_Protein(g)"],
      "Total fat(g)": mealData.Lunch["Lunch_Total_fat(g)"],
      "Carbohydrates(g)": mealData.Lunch["Lunch_Carbohydrates(g)"],
      "Total Dietary Fibre(g)": mealData.Lunch["Lunch_Total_Dietary_Fibre(g)"],
      "Vitamin A(µg)": mealData.Lunch["Lunch_Vitamin_A(µg)"],
      "Vitamin D(µg)": mealData.Lunch["Lunch_Vitamin_D(µg)"],
      "Vitamin K(µg)": mealData.Lunch["Lunch_Vitamin_K(µg)"],
      "Vitamin E(mg)": mealData.Lunch["Lunch_Vitamin_E(mg)"],
      "Calcium(mg)": mealData.Lunch["Lunch_Calcium(mg)"],
      "Phosphorus(mg)": mealData.Lunch["Lunch_Phosphorus(mg)"],
      "Magnesium(mg)": mealData.Lunch["Lunch_Magnesium(mg)"],
      "Sodium(mg)": mealData.Lunch["Lunch_Sodium(mg)"],
      "Potassium(mg)": mealData.Lunch["Lunch_Potassium(mg)"],
      "Saturated Fatty Acids(mg)":
        mealData.Lunch["Lunch_Saturated_Fatty_Acids(mg)"],
      "Monounsaturated Fatty Acids(mg)":
        mealData.Lunch["Lunch_Monounsaturated_Fatty_Acids(mg)"],
      "Polyunsaturated Fatty Acids(mg)":
        mealData.Lunch["Lunch_Polyunsaturated_Fatty_Acids(mg)"],
      "Free sugar(g)": mealData.Lunch["Lunch_Free_sugar(g)"],
      "Starch(g)": mealData.Lunch["Lunch_Starch(g)"],
    };
  };

  const mapDinnerMealDataToRequestBody = (mealData: any) => {
    return {
      "Main Meal": mealData.Dinner.Dinner_Main_Meal,
      "Side Meal": mealData.Dinner.Dinner_Side_Meal,
      "Complete Meal": mealData.Dinner.Dinner_Complete_Meal,
      Breakfast_Probability: mealData.Dinner.Dinner_Breakfast_Probability, // Assuming probability fields for dinner exist
      Lunch_Probability: mealData.Dinner.Dinner_Lunch_Probability, // Assuming probability fields for dinner exist
      Dinner_Probability: mealData.Dinner.Dinner_Dinner_Probability, // Assuming probability fields for dinner exist
      Combined_Meal: mealData.Dinner.Dinner_Combined_Meal, // Assuming Combined_Meal field for dinner
      Ingredients: mealData.Dinner.Dinner_Ingredients,
      Quantities: mealData.Dinner.Dinner_Quantities,
      "Energy(Kcal)": mealData.Dinner["Dinner_Energy(Kcal)"],
      "Protein(g)": mealData.Dinner["Dinner_Protein(g)"],
      "Total fat(g)": mealData.Dinner["Dinner_Total_fat(g)"],
      "Carbohydrates(g)": mealData.Dinner["Dinner_Carbohydrates(g)"],
      "Total Dietary Fibre(g)":
        mealData.Dinner["Dinner_Total_Dietary_Fibre(g)"],
      "Vitamin A(µg)": mealData.Dinner["Dinner_Vitamin_A(µg)"],
      "Vitamin D(µg)": mealData.Dinner["Dinner_Vitamin_D(µg)"],
      "Vitamin K(µg)": mealData.Dinner["Dinner_Vitamin_K(µg)"],
      "Vitamin E(mg)": mealData.Dinner["Dinner_Vitamin_E(mg)"],
      "Calcium(mg)": mealData.Dinner["Dinner_Calcium(mg)"],
      "Phosphorus(mg)": mealData.Dinner["Dinner_Phosphorus(mg)"],
      "Magnesium(mg)": mealData.Dinner["Dinner_Magnesium(mg)"],
      "Sodium(mg)": mealData.Dinner["Dinner_Sodium(mg)"],
      "Potassium(mg)": mealData.Dinner["Dinner_Potassium(mg)"],
      "Saturated Fatty Acids(mg)":
        mealData.Dinner["Dinner_Saturated_Fatty_Acids(mg)"],
      "Monounsaturated Fatty Acids(mg)":
        mealData.Dinner["Dinner_Monounsaturated_Fatty_Acids(mg)"],
      "Polyunsaturated Fatty Acids(mg)":
        mealData.Dinner["Dinner_Polyunsaturated_Fatty_Acids(mg)"],
      "Free sugar(g)": mealData.Dinner["Dinner_Free_sugar(g)"],
      "Starch(g)": mealData.Dinner["Dinner_Starch(g)"],
    };
  };

  useEffect(() => {
    console.log("Load Component ------------------------------------------+ ");

    const fetchMealPlan = async () => {
      console.log("GET Component ------------------------------------------+ ");
      try {
        const response = await axios.get(`/api/mealplans/index`);

        setMealIndex(response.data.last_index);
      } catch (error) {
        console.error("Error fetching meal item details: ", error);
      }
    };
    fetchMealPlan();
    console.log("GET Component ------------------------------------------+ ");
  }, []);

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

  // create async api method to save meal data
  const saveMealData = async (mealData: any) => {
    try {
      const response = await axios.post(`/api/mealplans/add`, mealData);
      console.log("Response: ", response.data);
    } catch (error) {
      console.error("Error saving meal data: ", error);
    }
  };

  // / Handle form data submission and save to appropriate meal section
  const handleSave = async (formData: any) => {
    const updatedNotifications = [...notifications];

    if (currentSection === 0 && !notifications.includes("Breakfast")) {
      console.log("Breakfast data: ", mealsData.Breakfast);
      // await saveMealData(mealsData.Breakfast);
      updatedNotifications.push("Breakfast");

      console.log("Breakfast data: ", mealsData.Breakfast);
    } else if (currentSection === 1 && !notifications.includes("Lunch")) {
      console.log("Lunch -- ", mealsData.Lunch);
      // await saveMealData(mealsData.Breakfast)
      updatedNotifications.push("Lunch");
    } else if (currentSection === 2 && !notifications.includes("Dinner")) {
      console.log("Dinner data ", mealsData.Dinner);
      // await saveMealData(mealsData.Breakfast)
      updatedNotifications.push("Dinner");
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
      Number(mealsData.Breakfast["Breakfast_Total_fat(g)"]) +
      Number(mealsData.Lunch["Lunch_Total_fat(g)"]) +
      Number(mealsData.Dinner["Dinner_Total_fat(g)"]);

    const totalCarbohydrates =
      Number(mealsData.Breakfast["Breakfast_Carbohydrates(g)"]) +
      Number(mealsData.Lunch["Lunch_Carbohydrates(g)"]) +
      Number(mealsData.Dinner["Dinner_Carbohydrates(g)"]);

    const totalMagnesium =
      Number(mealsData.Breakfast["Breakfast_Magnesium(mg)"]) +
      Number(mealsData.Lunch["Lunch_Magnesium(mg)"]) +
      Number(mealsData.Dinner["Dinner_Magnesium(mg)"]);

    const totalSodium =
      Number(mealsData.Breakfast["Breakfast_Sodium(mg)"]) +
      Number(mealsData.Lunch["Lunch_Sodium(mg)"]) +
      Number(mealsData.Dinner["Dinner_Sodium(mg)"]);

    const totalPotassium =
      Number(mealsData.Breakfast["Breakfast_Potassium(mg)"]) +
      Number(mealsData.Lunch["Lunch_Potassium(mg)"]) +
      Number(mealsData.Dinner["Dinner_Potassium(mg)"]);

    const totalSaturatedFattyAcids =
      Number(mealsData.Breakfast["Breakfast_Saturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Lunch["Lunch_Saturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Dinner["Dinner_Saturated_Fatty_Acids(mg)"]);

    const totalMonounsaturatedFattyAcids =
      Number(mealsData.Breakfast["Breakfast_Monounsaturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Lunch["Lunch_Monounsaturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Dinner["Dinner_Monounsaturated_Fatty_Acids(mg)"]);

    const totalPolyunsaturatedFattyAcids =
      Number(mealsData.Breakfast["Breakfast_Polyunsaturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Lunch["Lunch_Polyunsaturated_Fatty_Acids(mg)"]) +
      Number(mealsData.Dinner["Dinner_Polyunsaturated_Fatty_Acids(mg)"]);

    const totalFreeSugar =
      Number(mealsData.Breakfast["Breakfast_Free_sugar(g)"]) +
      Number(mealsData.Lunch["Lunch_Free_sugar(g)"]) +
      Number(mealsData.Dinner["Dinner_Free_sugar(g)"]);

    const totalStarch =
      Number(mealsData.Breakfast["Breakfast_Starch(g)"]) +
      Number(mealsData.Lunch["Lunch_Starch(g)"]) +
      Number(mealsData.Dinner["Dinner_Starch(g)"]);

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
      index: mealIndex + 1,
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
              name="Breakfast_Breakfast_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter breakfast probability"
            />
            <FormTextField
              label="Lunch Probability"
              name="Breakfast_Lunch_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter lunch probability"
            />
            <FormTextField
              label="Dinner Probability"
              name="Breakfast_Dinner_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter dinner probability"
            />
            <FormTextField
              label="Combined Meal"
              name="Breakfast_Combined_Meal"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter combined meal count"
            />
            <FormTextField
              label="Ingredients"
              name="Breakfast_Ingredients"
              onChange={handleInputChange}
              placeholder="Enter ingredients"
            />
            <FormTextField
              label="Quantities"
              name="Breakfast_Quantities"
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
              label="Breakfast Probability"
              name="Lunch_Breakfast_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter breakfast probability"
            />
            <FormTextField
              label="Lunch Probability"
              name="Lunch_Lunch_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter lunch probability"
            />
            <FormTextField
              label="Dinner Probability"
              name="Lunch_Dinner_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter dinner probability"
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
              label="Breakfast Probability"
              name="Dinner_Breakfast_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter breakfast probability"
            />
            <FormTextField
              label="Lunch Probability"
              name="Dinner_Lunch_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter lunch probability"
            />
            <FormTextField
              label="Dinner Probability"
              name="Dinner_Dinner_Probability"
              type="number"
              onChange={handleInputChange}
              placeholder="Enter dinner probability"
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
