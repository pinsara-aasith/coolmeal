"use client";
import React, { useEffect, useState } from "react";
import Search from "../dashboard/search/search";
import { Card, Table } from "@radix-ui/themes";
import axios from "axios";

interface MealPlan {
  id: string;
  totalSodiumMg: number;
  combinedIngredients: string;
  totalStarchG: number;
  totalFreeSugarG: number;
  totalPotassiumMg: number;
  totalFatG: number;
  totalProteinG: number;
  totalMagnesiumMg: number;
  totalEnergyKcal: number;
  lunch: string;
  dinner: string;
  totalPolyunsaturatedFattyAcidsMg: number;
  totalSaturatedFattyAcidsMg: number;
  totalCarbohydratesG: number;
  breakfast: string;
  totalMonounsaturatedFattyAcidsMg: number;
  generatedTimes: number;
}

const MealTable = () => {
  const [meals, setMeals] = useState<MealPlan[]>([]);
  const [isLoaded, setIsLoaded] = useState(false); // Add a state to track when data is loaded

  useEffect(() => {
    const fetchMeals = async () => {
      try {
        const response = await axios.get("/api/dashboard/meals");
        setMeals(response.data);
        setIsLoaded(true); // Mark data as loaded after fetching
      } catch (error) {
        console.error("Error fetching meals: ", error);
        setIsLoaded(true); // Ensure loading is finished even if there is an error
      }
    };
    fetchMeals();
  }, []);

  if (!isLoaded) {
    // Optionally render a loading state while fetching data
    return <div>Loading...</div>;
  }

  return (
    <Card className="m-5 max-h-screen">
      <div className="ml-5 mt-5">
        <Search placeholder="Search food items" />
      </div>

      <div className="m-5">
        <Table.Root>
          <div className="max-h-[500px] overflow-y-auto">
            <Table.Header className="sticky top-0 bg-white z-10">
              {/* Sticky table header */}
              <Table.Row>
                <Table.ColumnHeaderCell>Breakfast</Table.ColumnHeaderCell>
                <Table.ColumnHeaderCell>Lunch</Table.ColumnHeaderCell>
                <Table.ColumnHeaderCell>Dinner</Table.ColumnHeaderCell>
                <Table.ColumnHeaderCell>Ingredients</Table.ColumnHeaderCell>
              </Table.Row>
            </Table.Header>

            <Table.Body>
              {/* Scrollable table body */}
              {meals.map((meal) => (
                <Table.Row key={meal.id}>
                  <Table.Cell>{meal.breakfast}</Table.Cell>
                  <Table.Cell>{meal.lunch}</Table.Cell>
                  <Table.Cell>{meal.dinner}</Table.Cell>
                  <Table.Cell>{meal.combinedIngredients}</Table.Cell>
                </Table.Row>
              ))}
            </Table.Body>
          </div>
        </Table.Root>
      </div>
    </Card>
  );
};

export default MealTable;
