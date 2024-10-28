"use client";

import LoadingSkeleton from "@/app/ui/common/loadingSkeleton"; // Loading skeleton
import { Card, Text } from "@radix-ui/themes";
import axios from "axios";
import { useSearchParams } from "next/navigation";
import { useEffect, useState } from "react";
import Table from "../../ui/common/table";
import Search from "../../ui/dashboard/search/search"; // Assuming common component

// Define columns for the Table component
const columns = [
  { header: "Main Meal", accessor: "Main Meal", className: "font-bold" },
  { header: "Side Meal", accessor: "Side Meal", className: "font-bold" },
  {
    header: "Complete Meal",
    accessor: "Complete Meal",
    className: "font-bold",
  },
  { header: "Combined Meal", accessor: "Combined_Meal" },
  { header: "Complete Meal", accessor: "Complete Meal" },
  { header: "Ingredients", accessor: "Ingredients" },
  { header: "Quantities", accessor: "Quantities" },
  { header: "Meal Ingredient IDs", accessor: "Meal_Ingredient_Ids" },
  { header: "Energy (Kcal)", accessor: "Energy(Kcal)" },
  { header: "Protein (g)", accessor: "Protein(g)" },
  { header: "Total Fat (g)", accessor: "Total fat(g)" },
  { header: "Carbohydrates (g)", accessor: "Carbohydrates(g)" },
  { header: "Total Dietary Fibre (g)", accessor: "Total Dietary Fibre(g)" },
  { header: "Vitamin A (µg)", accessor: "Vitamin A(µg)" },
  { header: "Vitamin D (µg)", accessor: "Vitamin D(µg)" },
  { header: "Vitamin E (mg)", accessor: "Vitamin E(mg)" },
  { header: "Calcium (mg)", accessor: "Calcium(mg)" },
  { header: "Phosphorus (mg)", accessor: "Phosphorus(mg)" },
  { header: "Magnesium (mg)", accessor: "Magnesium(mg)" },
  { header: "Sodium (mg)", accessor: "Sodium(mg)" },
  { header: "Potassium (mg)", accessor: "Potassium(mg)" },
  {
    header: "Saturated Fatty Acids (mg)",
    accessor: "Saturated Fatty Acids(mg)",
  },
  {
    header: "Monounsaturated Fatty Acids (mg)",
    accessor: "Monounsaturated Fatty Acids(mg)",
  },
  {
    header: "Polyunsaturated Fatty Acids (mg)",
    accessor: "Polyunsaturated Fatty Acids(mg)",
  },
  { header: "Free Sugar (g)", accessor: "Free sugar(g)" },
  { header: "Starch (g)", accessor: "Starch(g)" },
  { header: "Price", accessor: "Price" },
  { header: "Vitamin K (µg)", accessor: "Vitamin K(µg)" },
];

const MealsTable = () => {
  const [meals, setMeals] = useState<any[]>([]);
  const [filteredMeals, setFilteredMeals] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true); // Loading state
  const searchParams = useSearchParams();

  // Fetch data from API
  const fetchMeals = async () => {
    try {
      const response = await axios.get("/api/meals"); // Adjusted endpoint to /api/meals
      console.log(response.data);
      setMeals(response.data);
    } catch (error) {
      console.error("Error fetching meal data: ", error);
    } finally {
      setLoading(false);
    }
  };

  // Load meals on component mount
  useEffect(() => {
    setLoading(true);
    fetchMeals();
  }, []);

  // Filter meals based on search query
  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = meals.filter((meal) =>
      meal["Complete Meal"].toLowerCase().includes(query.toLowerCase())
    );

    setFilteredMeals(filtered);
  }, [searchParams, meals]);

  const tableData = filteredMeals.map((mi) => ({
    ...mi,
    _id: (
      <Text className="text-blue-600 hover:underline font-bold">{mi._id}</Text>
    ),
  }));

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="Search for meals" />
      <div className="overflow-x-auto mt-5">
        <div className="overflow-y-auto">
          <div className="overflow-auto max-h-[520px] max-w-full">
            {loading ? (
              <LoadingSkeleton />
            ) : (
              <Table columns={columns} data={tableData} />
            )}
          </div>
        </div>
      </div>
    </Card>
  );
};

export default MealsTable;
