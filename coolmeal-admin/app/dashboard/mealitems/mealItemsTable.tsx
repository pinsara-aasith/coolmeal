"use client";

import React, { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import axios from "axios";
import Link from "next/link";
import Search from "../../ui/dashboard/search/search"; // Assuming common component
import LoadingSkeleton from "@/app/ui/common/loadingSkeleton"; // Loading skeleton
import Table from "../../ui/common/table";
import { Badge, Card, Text } from "@radix-ui/themes";

// Define columns for the Table component
const columns = [
  { header: "Meal ID", accessor: "_id", className: "font-bold" },
  { header: "Name", accessor: "Name", className: "font-bold" },
  { header: "Ingredients", accessor: "Meal_Ingredients_Names" },
  { header: "Quantities", accessor: "Meal_Ingredient_Quantities" },
  { header: "Category", accessor: "Category", className: "font-bold" },
  { header: "Description", accessor: "Description" },
  { header: "Morning Probability", accessor: "Morning_Probability" },
  { header: "Lunch Probability", accessor: "Lunch_Probability" },
  { header: "Dinner Probability", accessor: "Dinner_Probability" },
];

const MealItemsTable = () => {
  const [mealitems, setMealitems] = useState<any[]>([]);
  const [filteredMealitems, setFilteredMealitems] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true); // Loading state
  const searchParams = useSearchParams();

  // Fetch data from API
  const fetchMealitems = async () => {
    try {
      const response = await axios.get("/api/mealitems"); // Adjusted endpoint to /api/mealitems
      console.log(response.data);
      setMealitems(response.data);
    } catch (error) {
      console.error("Error fetching mealitem data: ", error);
    } finally {
      setLoading(false);
    }
  };

  // Load mealitems on component mount
  useEffect(() => {
    setLoading(true);
    fetchMealitems();
  }, []);

  // Filter mealitems based on search query
  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = mealitems.filter((mealitem) =>
      mealitem.Name.toLowerCase().includes(query.toLowerCase())
    );

    setFilteredMealitems(filtered);
  }, [searchParams, mealitems]);

  const tableData = filteredMealitems.map((mi) => ({
    ...mi,
    _id: (
      <Text className="text-blue-600 hover:underline font-bold">
        {mi._id.toUpperCase()}
      </Text>
    ),
  }));

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="Search for meal items" />
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

export default MealItemsTable;
