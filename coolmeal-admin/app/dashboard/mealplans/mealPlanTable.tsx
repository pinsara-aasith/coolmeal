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
  { header: "Breakfast", accessor: "Breakfast", className: "font-bold" },
  { header: "Lunch", accessor: "Lunch", className: "font-bold" },
  { header: "Dinner", accessor: "Dinner", className: "font-bold" },
  { header: "Price", accessor: "Price" },
  { header: "Total Energy (Kcal)", accessor: "Total Energy(Kcal)" },
  { header: "Total Protein (g)", accessor: "Total Protein(g)" },
  { header: "Total Fat (g)", accessor: "Total fat(g)" },
  { header: "Total Carbohydrates (g)", accessor: "Total Carbohydrates(g)" },
  { header: "Total Magnesium (mg)", accessor: "Total Magnesium(mg)" },
  { header: "Total Sodium (mg)", accessor: "Total Sodium(mg)" },
  { header: "Total Potassium (mg)", accessor: "Total Potassium(mg)" },
  {
    header: "Total Saturated Fatty Acids (mg)",
    accessor: "Total Saturated Fatty Acids(mg)",
  },
  {
    header: "Total Monounsaturated Fatty Acids (mg)",
    accessor: "Total Monounsaturated Fatty Acids(mg)",
  },
  {
    header: "Total Polyunsaturated Fatty Acids (mg)",
    accessor: "Total Polyunsaturated Fatty Acids(mg)",
  },
  { header: "Total Free Sugar (g)", accessor: "Total Free sugar(g)" },
  { header: "Total Starch (g)", accessor: "Total Starch(g)" },
];

const MealPlansTable = () => {
  const [mealplans, setMealPlans] = useState<any[]>([]);
  const [filteredMealPlans, setFilteredMealPlans] = useState<any[]>([]);
  const [loading, setLoading] = useState<boolean>(true); // Loading state
  const searchParams = useSearchParams();

  // Fetch data from API
  const fetchMealPlans = async () => {
    try {
      const response = await axios.get("/api/mealplans"); // Adjusted endpoint to /api/mealplans
      console.log(response.data);
      setMealPlans(response.data);
    } catch (error) {
      console.error("Error fetching mealplan data: ", error);
    } finally {
      setLoading(false);
    }
  };

  // Load mealplans on component mount
  useEffect(() => {
    setLoading(true);
    fetchMealPlans();
  }, []);

  // Filter mealplans based on search query
  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = mealplans.filter((mealplan) =>
      JSON.stringify(mealplan)?.toLowerCase().includes(query.toLowerCase())
    );
    console.log(filtered, mealplans, "filtered");
    setFilteredMealPlans(filtered);
  }, [searchParams, mealplans]);

  const tableData = filteredMealPlans.map((mi) => ({
    ...mi,
    _id: <Text className="text-blue-600 hover:underline font-bold"></Text>,
  }));

  return (
    <Card className="ml-5 mt-5  text-white">
      <Search placeholder="Search for meal plans" />
      <div className="overflow-x-auto mt-5">
        <div className="overflow-y-auto">
          <div className="overflow-auto max-h-[550px] max-w-full">
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

export default MealPlansTable;
