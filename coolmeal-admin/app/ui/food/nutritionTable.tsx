"use client";

import { Table } from "@radix-ui/themes";
import axios from "axios";
import React, { useEffect, useState } from "react";
import Search from "../dashboard/search/search";
import { useSearchParams } from "next/navigation";
import Link from "next/link";

interface Foods {
  foodName: string;
  id: string;
  energyKcal: number; // Use number to accept float values
  proteinG: number;
  totalFatG: number;
  carbohydratesG: number;
  totalDietaryFibreG: number;
  freeSugarG: number;
  starchG: number;
  viatminKUg: number; // Corrected the spelling from 'viatminK' to 'vitaminK'
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

const NutritionTable = () => {
  const [foods, setFoods] = useState<Foods[]>([]);
  const [filteredfoods, setFilteredFoods] = useState<Foods[]>([]); // New state for filtered users
  const searchParams = useSearchParams(); // Get search params
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("/api/dashboard/foods");
        setFoods(response.data); // Set the users data
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };

    fetchUsers();
  }, []);

  useEffect(() => {
    const query = searchParams.get("q") || ""; // Get the search query
    const filtered = foods.filter((food) =>
      food.foodName.toLowerCase().includes(query.toLowerCase())
    );
    setFilteredFoods(filtered); // Update filtered users
  }, [searchParams, foods]); // Re-run when search query or users data changes

  return (
    <div>
      <div className="ml-5">
        <Search placeholder="search food items" />
      </div>

      <Table.Root className="m-5">
        <Table.Header>
          <Table.Row>
            <Table.ColumnHeaderCell>Food Name</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Energy (Kcal)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Protein (g)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Total Fat (g)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Carbohydrates (g)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>
              Total Dietary Fibre (g)
            </Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Free Sugar (g)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Starch (g)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Vitamin A (µg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Vitamin D (µg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Vitamin K (µg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Vitamin E (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Calcium (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Phosphorus (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Magnesium (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Sodium (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>Potassium (mg)</Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>
              Saturated Fatty Acids (mg)
            </Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>
              Monounsaturated Fatty Acids (mg)
            </Table.ColumnHeaderCell>
            <Table.ColumnHeaderCell>
              Polyunsaturated Fatty Acids (mg)
            </Table.ColumnHeaderCell>
          </Table.Row>
        </Table.Header>

        <Table.Body>
          {filteredfoods.map((food) => (
            <Table.Row key={food.id}>
              <Link href={"/dashboard/nutrition/" + food.id}>
                <Table.Cell>{food.foodName}</Table.Cell>
              </Link>

              <Table.Cell>{food.energyKcal}</Table.Cell>
              <Table.Cell>{food.proteinG}</Table.Cell>
              <Table.Cell>{food.totalFatG}</Table.Cell>
              <Table.Cell>{food.carbohydratesG}</Table.Cell>
              <Table.Cell>{food.totalDietaryFibreG}</Table.Cell>
              <Table.Cell>{food.freeSugarG}</Table.Cell>
              <Table.Cell>{food.starchG}</Table.Cell>
              <Table.Cell>{food.vitaminAUg}</Table.Cell>
              <Table.Cell>{food.vitaminDUg}</Table.Cell>
              <Table.Cell>{food.viatminKUg}</Table.Cell>
              <Table.Cell>{food.vitaminEMg}</Table.Cell>
              <Table.Cell>{food.calciumMg}</Table.Cell>
              <Table.Cell>{food.phosphorusMg}</Table.Cell>
              <Table.Cell>{food.magnesiumMg}</Table.Cell>
              <Table.Cell>{food.sodiumMg}</Table.Cell>
              <Table.Cell>{food.potassiumMg}</Table.Cell>
              <Table.Cell>{food.saturatedFattyAcidsMg}</Table.Cell>
              <Table.Cell>{food.monounsaturatedFattyAcidsMg}</Table.Cell>
              <Table.Cell>{food.polyunsaturatedFattyAcidsMg}</Table.Cell>
            </Table.Row>
          ))}
        </Table.Body>
      </Table.Root>
    </div>
  );
};

export default NutritionTable;
