"use client";

import React, { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import axios from "axios";
import Link from "next/link";
import Search from "../dashboard/search/search"; // Assuming this is the common component
import LoadingSkeleton from "@/app/ui/common/loadingSkeleton"; // Loading skeleton
import Table from "../common/table";
import { Card } from "@radix-ui/themes";

interface Foods {
  foodName: string;
  id: string;
  energyKcal: number;
  proteinG: number;
  totalFatG: number;
  carbohydratesG: number;
  totalDietaryFibreG: number;
  freeSugarG: number;
  starchG: number;
  viatminKUg: number;
  vitaminDUg: number;
  vitaminAUg: number;
  vitaminEMg: number;
  calciumMg: number;
  phosphorusMg: number;
  magnesiumMg: number;
  sodiumMg: number;
  potassiumMg: number;
  monounsaturatedFattyAcidsMg: number;
  polyunsaturatedFattyAcidsMg: number;
  saturatedFattyAcidsMg: number;
}

const columns = [
  { header: "Food Name", accessor: "foodName", className: 'font-bold' },
  { header: "Energy (Kcal)", accessor: "energyKcal" },
  { header: "Protein (g)", accessor: "proteinG" },
  { header: "Total Fat (g)", accessor: "totalFatG" },
  { header: "Carbohydrates (g)", accessor: "carbohydratesG" },
  { header: "Total Dietary Fibre (g)", accessor: "totalDietaryFibreG" },
  { header: "Free Sugar (g)", accessor: "freeSugarG" },
  { header: "Starch (g)", accessor: "starchG" },
  { header: "Vitamin A (µg)", accessor: "vitaminAUg" },
  { header: "Vitamin D (µg)", accessor: "vitaminDUg" },
  { header: "Vitamin K (µg)", accessor: "viatminKUg" },
  { header: "Vitamin E (mg)", accessor: "vitaminEMg" },
  { header: "Calcium (mg)", accessor: "calciumMg" },
  { header: "Phosphorus (mg)", accessor: "phosphorusMg" },
  { header: "Magnesium (mg)", accessor: "magnesiumMg" },
  { header: "Sodium (mg)", accessor: "sodiumMg" },
  { header: "Potassium (mg)", accessor: "potassiumMg" },
  { header: "Saturated Fatty Acids (mg)", accessor: "saturatedFattyAcidsMg" },
  { header: "Monounsaturated Fatty Acids (mg)", accessor: "monounsaturatedFattyAcidsMg" },
  { header: "Polyunsaturated Fatty Acids (mg)", accessor: "polyunsaturatedFattyAcidsMg" },
];

const NutritionTable = () => {
  const [foods, setFoods] = useState<Foods[]>([]);
  const [filteredFoods, setFilteredFoods] = useState<Foods[]>([]);
  const [loading, setLoading] = useState<boolean>(true); // Loading state
  const searchParams = useSearchParams();

  const fetchFoods = async () => {
    try {
      const response = await axios.get("/api/dashboard/foods");
      setFoods(response.data);
    } catch (error) {
      console.error("Error fetching foods data: ", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    setLoading(true);
    fetchFoods();
  }, []);

  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = foods.filter((food) =>
      food.foodName.toLowerCase().includes(query.toLowerCase())
    );
    setFilteredFoods(filtered);
  }, [searchParams, foods]);

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="Search for food ingredients" />
      <div className="overflow-x-auto mt-5">
        <div className="overflow-y-auto">
          <div className="overflow-auto max-h-[550px] max-w-full">
            {loading ? (
              <LoadingSkeleton />
            ) : (
              <Table
                columns={columns}
                data={filteredFoods.map((food) => ({
                  ...food,
                  foodName: (
                    <Link href={`/dashboard/nutrition/${food.id}`} key={food.id}>
                      {food.foodName}
                    </Link>
                  ),
                }))}
              />
            )}
          </div>
        </div>
      </div></Card>
  );
};

export default NutritionTable;
