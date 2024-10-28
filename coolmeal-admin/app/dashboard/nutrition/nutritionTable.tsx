"use client";

import React, { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import axios from "axios";
import Link from "next/link";
import Search from "../../ui/dashboard/search/search"; // Assuming this is the common component
import LoadingSkeleton from "@/app/ui/common/loadingSkeleton"; // Loading skeleton
import Table from "../../ui/common/table";
import { Card } from "@radix-ui/themes";

interface Ingredients {
  id: string;
  Food_Code: string;
  Price_Code: number;
  Food_Name: string;
  "Energy (Kcal)": number;
  "Protein(g)": number;
  "Total fat(g)": number;
  "Carbohydrates(g)": number;
  "Total Dietary Fibre(g)": number;
  "Free sugar(g)": number;
  Starch: number;
  "Vitamin A(µg)": number;
  "Vitamin D(µg)": number;
  "Vitamin K(µg)": number;
  "Vitamin E(mg)": number;
  "Calcium(mg)": number;
  "Phosphorus(mg)": number;
  "Magnesium(mg)": number;
  "Sodium(mg)": number;
  "Potassium(mg)": number;
  "Saturated Fatty Acids(mg)": number;
  "Monounsaturated Fatty Acids(mg)": number;
  "Polyunsaturated Fatty Acids(mg)": number;
}

const columns = [
  {
    header: "Food Code",
    accessor: "Food_Code",
    className: "font-bold",
  },
  {
    header: "Price Code",
    accessor: "Price_Code",
  },
  {
    header: "Food Name",
    accessor: "Food_Name",
  },
  {
    header: "Energy(Kcal)",
    accessor: "Energy(Kcal)",
  },
  {
    header: "Protein(g)",
    accessor: "Protein(g)",
  },
  {
    header: "Total fat(g)",
    accessor: "Total fat(g)",
  },
  {
    header: "Carbohydrates(g)",
    accessor: "Carbohydrates(g)",
  },
  {
    header: "Total Dietary Fibre(g)",
    accessor: "Total Dietary Fibre(g)",
  },
  {
    header: "Free sugar(g)",
    accessor: "Free sugar(g)",
  },
  {
    header: "Starch(g)",
    accessor: "Starch(g)",
  },
  {
    header: "Vitamin A(µg)",
    accessor: "Vitamin A(µg)",
  },
  {
    header: "Vitamin D(µg)",
    accessor: "Vitamin D(µg)",
  },
  {
    header: "Vitamin K(µg)",
    accessor: "Vitamin K(µg)",
  },
  {
    header: "Vitamin E(mg)",
    accessor: "Vitamin E(mg)",
  },
  {
    header: "Calcium(mg)",
    accessor: "Calcium(mg)",
  },
  {
    header: "Phosphorus(mg)",
    accessor: "Phosphorus(mg)",
  },
  {
    header: "Magnesium(mg)",
    accessor: "Magnesium(mg)",
  },
  {
    header: "Sodium(mg)",
    accessor: "Sodium(mg)",
  },
  {
    header: "Potassium(mg)",
    accessor: "Potassium(mg)",
  },
  {
    header: "Saturated Fatty Acids(mg)",
    accessor: "Saturated Fatty Acids(mg)",
  },
  {
    header: "Monounsaturated Fatty Acids(mg)",
    accessor: "Monounsaturated Fatty Acids(mg)",
  },
  {
    header: "Polyunsaturated Fatty Acids(mg)",
    accessor: "Polyunsaturated Fatty Acids(mg)",
  },
];

const NutritionTable = () => {
  const [ingredients, setIngredients] = useState<Ingredients[]>([]);
  const [filteredIngredients, setFilteredIngredients] = useState<Ingredients[]>(
    []
  );
  const [loading, setLoading] = useState<boolean>(true); // Loading state
  const searchParams = useSearchParams();

  const fetchIngredients = async () => {
    try {
      const response = await axios.get("/api/ingredients");
      console.log(response.data);
      setIngredients(response.data);
    } catch (error) {
      console.error("Error fetching ingredients data: ", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    setLoading(true);
    fetchIngredients();
  }, []);

  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = ingredients.filter((ingredient) =>
      ingredient["Food_Name"]?.toLowerCase().includes(query.toLowerCase())
    );
    console.log(filtered, ingredients, "fitlered");
    setFilteredIngredients(filtered);
  }, [searchParams, ingredients]);

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="Search for ingredients" />
      <div className="overflow-x-auto mt-5">
        <div className="overflow-y-auto">
          <div className="overflow-auto max-h-[520px] max-w-full">
            {loading ? (
              <LoadingSkeleton />
            ) : (
              <Table
                columns={columns}
                data={filteredIngredients.map((ingredient) => ({
                  ...ingredient,
                  Food_Name: (
                    <Link
                      href={`/dashboard/nutrition/${ingredient.id}`}
                      key={ingredient.id}
                    >
                      {ingredient["Food_Name"]}
                    </Link>
                  ),
                }))}
              />
            )}
          </div>
        </div>
      </div>
    </Card>
  );
};

export default NutritionTable;
