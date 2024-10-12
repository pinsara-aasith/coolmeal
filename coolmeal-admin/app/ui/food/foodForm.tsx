"use client";
import { addFood } from "@/app/lib/actions";
import { Button, Flex, Text, TextField } from "@radix-ui/themes";
import axios from "axios";
import React, { useEffect, useState } from "react";

interface Foods {
  foodName: string;
  foodId: string;
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
interface Props {
  params?: {
    id: string;
  };
}

const FoodForm = ({ params }: Props) => {
  const [food, setFood] = useState<Foods | null>(null);
  const nutritions = [
    {
      title: "Macronutrients",
      list: [
        {
          title: "Energy",
          placeholder: "add energy in Kcal",
          key: "energyKcal",
        },
        { title: "Protein", placeholder: "add protein in g", key: "proteinG" },
        {
          title: "Total fat",
          placeholder: "add total fat in g",
          key: "totalFatG",
        },
        {
          title: "Carbohydrates",
          placeholder: "add carbohydrate in g",
          key: "carbohydratesG",
        },
        {
          title: "Total Dietary Fibre",
          placeholder: "add total dietary fibre in g",
          key: "totalDietaryFibreG",
        },
        {
          title: "Free sugar",
          placeholder: "add free sugar in g",
          key: "freeSugarG",
        },
        { title: "Starch", placeholder: "add starch in g", key: "starchG" },
      ],
    },
    {
      title: "Vitamins",
      list: [
        {
          title: "Vitamin A",
          placeholder: "add vitamin A in µg",
          key: "vitaminAUg",
        },
        {
          title: "Vitamin D",
          placeholder: "add vitamin D in µg",
          key: "vitaminDUg",
        },
        {
          title: "Vitamin K",
          placeholder: "add vitamin K in µg",
          key: "viatminKUg",
        },
        {
          title: "Vitamin E",
          placeholder: "add vitamin E in mg",
          key: "vitaminEMg",
        },
      ],
    },
    {
      title: "Minerals",
      list: [
        {
          title: "Calcium",
          placeholder: "add calcium in mg",
          key: "calciumMg",
        },
        {
          title: "Phosphorus",
          placeholder: "add phosphorus in mg",
          key: "phosphorusMg",
        },
        {
          title: "Magnesium",
          placeholder: "add magnesium in mg",
          key: "magnesiumMg",
        },
        { title: "Sodium", placeholder: "add sodium in mg", key: "sodiumMg" },
        {
          title: "Potassium",
          placeholder: "add potassium in mg",
          key: "potassiumMg",
        },
      ],
    },
    {
      title: "Fatty Acids",
      list: [
        {
          title: "Saturated Fatty Acids",
          placeholder: "add saturated fatty acid amount in mg",
          key: "saturatedFattyAcidsMg",
        },
        {
          title: "Monounsaturated Fatty Acids",
          placeholder: "add monounsaturated fatty acids in mg",
          key: "monounsaturatedFattyAcidsMg",
        },
        {
          title: "Polyunsaturated Fatty Acids",
          placeholder: "add polyunsaturated fatty acids in mg",
          key: "polyunsaturatedFattyAcidsMg",
        },
      ],
    },
  ];

  useEffect(() => {
    const fetchUsers = async () => {
      const id = params?.id;
      try {
        const response = await axios.get("/api/dashboard/foods/" + id);
        console.log(response.data);
        setFood(response.data); // Set the correct data
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };

    fetchUsers();
  }, [params?.id]);

  return (
    <div className="ml-5 mt-5 mr-5">
      <form action={addFood}>
        <Flex align="center" gap="5" className="mb-5 " justify="between">
          <Flex wrap="wrap" gap="5">
            <Text>Food item</Text>
            <TextField.Root
              defaultValue={food ? food.foodName : ""}
              placeholder="enter name of food"
            >
              <TextField.Slot></TextField.Slot>
            </TextField.Root>
          </Flex>
          <Button type="submit">Submit</Button>
        </Flex>

        {/* Map through each category */}
        {nutritions.map((nutrition) => (
          <div key={nutrition.title} className="mb-6">
            <Text weight="bold" className="mb-2">
              {nutrition.title}
            </Text>

            {/* Loop through the list items and ensure even layout */}
            {nutrition.list.map((item, index) => {
              if (index % 2 === 0) {
                return (
                  <Flex key={item.title} align="center" className="mb-3 gap-5">
                    {/* First item in the row */}
                    <Flex className="w-1/2 items-center gap-5">
                      <Text className="w-[150px]">{item.title}</Text>
                      <TextField.Root
                        defaultValue={food ? food[item.key as keyof Foods] : ""}
                        className="flex-grow"
                        placeholder={item.placeholder}
                      >
                        <TextField.Slot></TextField.Slot>
                      </TextField.Root>
                    </Flex>

                    {/* Second item in the row */}
                    {nutrition.list[index + 1] && (
                      <Flex className="w-1/2 items-center gap-5">
                        <Text className="w-[150px]">
                          {nutrition.list[index + 1].title}
                        </Text>
                        <TextField.Root
                          defaultValue={
                            food ? food[item.key as keyof Foods] : ""
                          }
                          className="flex-grow"
                          placeholder={nutrition.list[index + 1].placeholder}
                        >
                          <TextField.Slot></TextField.Slot>
                        </TextField.Root>
                      </Flex>
                    )}
                  </Flex>
                );
              }
              return null;
            })}
          </div>
        ))}
      </form>
    </div>
  );
};

export default FoodForm;
