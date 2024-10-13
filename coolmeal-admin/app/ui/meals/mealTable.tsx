"use client";
import React, { useEffect, useState } from "react";
import Search from "../dashboard/search/search";
import { Link, Table } from "@radix-ui/themes";
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

  useEffect(() => {
    const fetchMeals = async () => {
      try {
        const response = await axios.get("/api/dashboard/meals");
        setMeals(response.data);
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };
    fetchMeals();
  }, []);
  return (
    <div>
      <div className="ml-5">
        <Search placeholder="search food items" />
      </div>

      <Table.Root className="m-5">
        <Table.Header>
          <Table.Row>
            <Table.ColumnHeaderCell>Breakfast</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Lunch</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Dinner</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Ingreddients</Table.ColumnHeaderCell>
          </Table.Row>
        </Table.Header>

        <Table.Body>
          {meals.map((meal) => (
            <Table.Row key={meal.id}>
              {/* <Link href={"/dashboard/nutrition/" + meal.id}></Link> */}

              <Table.Cell>{meal.breakfast}</Table.Cell>
              <Table.Cell>{meal.lunch}</Table.Cell>
              <Table.Cell>{meal.dinner}</Table.Cell>
              <Table.Cell>{meal.combinedIngredients}</Table.Cell>
            </Table.Row>
          ))}
        </Table.Body>
      </Table.Root>
    </div>
  );
};

export default MealTable;
