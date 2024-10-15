"use client";
import { Button, Flex, Text } from "@radix-ui/themes";
import axios from "axios";
import Link from "next/link";
import { useEffect, useState } from "react";

interface Props {
  params: {
    id: string;
  };
}

interface Food {
  foodName: string;
  energyKcal: number;
  proteinG: number;
  totalFatG: number;
  carbohydratesG: number;
  totalDietaryFibreG: number;
  freeSugarG: number;
  starchG: number;
  vitaminKUg: number;
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

const FoodInfo = ({ params }: Props) => {
  const [food, setFood] = useState<Food | null>(null);

  const nutritions = [
    {
      title: "Macronutrients",
      list: [
        { title: "Energy", key: "energyKcal" },
        { title: "Protein", key: "proteinG" },
        { title: "Total fat", key: "totalFatG" },
        { title: "Carbohydrates", key: "carbohydratesG" },
        { title: "Total Dietary Fibre", key: "totalDietaryFibreG" },
        { title: "Free sugar", key: "freeSugarG" },
        { title: "Starch", key: "starchG" },
      ],
    },
    {
      title: "Vitamins",
      list: [
        { title: "Vitamin A", key: "vitaminAUg" },
        { title: "Vitamin D", key: "vitaminDUg" },
        { title: "Vitamin K", key: "viatminKUg" },
        { title: "Vitamin E", key: "vitaminEMg" },
      ],
    },
    {
      title: "Minerals",
      list: [
        { title: "Calcium", key: "calciumMg" },
        { title: "Phosphorus", key: "phosphorusMg" },
        { title: "Magnesium", key: "magnesiumMg" },
        { title: "Sodium", key: "sodiumMg" },
        { title: "Potassium", key: "potassiumMg" },
      ],
    },
    {
      title: "Fatty Acids",
      list: [
        { title: "Saturated Fatty Acids", key: "saturatedFattyAcidsMg" },
        {
          title: "Monounsaturated Fatty Acids",
          key: "monounsaturatedFattyAcidsMg",
        },
        {
          title: "Polyunsaturated Fatty Acids",
          key: "polyunsaturatedFattyAcidsMg",
        },
      ],
    },
  ];

  useEffect(() => {
    const fetchFood = async () => {
      try {
        const response = await axios.get("/api/dashboard/foods/" + params.id);
        setFood(response.data);
      } catch (error) {
        console.error("Error fetching food details: ", error);
      }
    };
    fetchFood();
  }, [params]);

  return (
    <div className="m-5">
      <Flex align="center" gap="5" className="mb-5 " justify="between">
        <Flex wrap="wrap" gap="5">
          <Text weight="medium">Food item</Text>
          <Text>{food?.foodName || "Loading..."}</Text>
        </Flex>
        <Flex gap="5">
          <Link href={"/dashboard/nutrition/add/" + params.id}>
            <Button type="submit">Edit Food item</Button>
          </Link>

          <Button color="red">Delete Food item</Button>
        </Flex>
      </Flex>

      {/* Map through each category */}
      {nutritions.map((nutrition) => (
        <div key={nutrition.title} className="mb-6">
          <Text weight="bold" className="mb-3">
            {nutrition.title}
          </Text>

          {/* Loop through the list items and ensure even layout */}
          {nutrition.list.map((item, index) => {
            if (index % 2 === 0) {
              return (
                <Flex key={item.title} align="center" className="mb-3 gap-5">
                  {/* First item in the row */}
                  <Flex className="w-1/3 items-center gap-5">
                    <Text weight="medium" className="w-[150px]">
                      {item.title}
                    </Text>
                    <Text weight="light">
                      {food
                        ? food[item.key as keyof Food] || "N/A"
                        : "Loading..."}
                    </Text>
                  </Flex>

                  {/* Second item in the row */}
                  {nutrition.list[index + 1] && (
                    <Flex className="w-1/2 items-center gap-5">
                      <Text weight="medium" className="w-[150px]">
                        {nutrition.list[index + 1].title}
                      </Text>
                      <Text weight="light">
                        {food
                          ? food[nutrition.list[index + 1].key as keyof Food] ||
                            "N/A"
                          : "Loading..."}
                      </Text>
                    </Flex>
                  )}
                </Flex>
              );
            }
            return null;
          })}
        </div>
      ))}
    </div>
  );
};

export default FoodInfo;
