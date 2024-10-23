"use client";
import CustomButton from "@/component/CustomButton";
import { AlertDialog, Button, Flex, Text } from "@radix-ui/themes";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/navigation";
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
  const router = useRouter();

  useEffect(() => {
    const fetchFood = async () => {
      try {
        const response = await axios.get("/api/dashboard/foods/" + params.id);
        console.log(params.id);
        setFood(response.data);
      } catch (error) {
        console.error("Error fetching food details: ", error);
      }
    };
    fetchFood();
  }, [params]);
  const deleteFood = async (id: string) => {
    try {
      const response = await axios.put("/api/dashboard/foods/" + id);
      router.push("/dashboard/nutrition");
      console.log(response);
    } catch (error) {
      console.error("Error fetching food details: ", error);
    }
  };

  return (
    <div className="m-5">
      <Flex align="center" gap="5" className="mb-5 " justify="between">
        <Flex wrap="wrap" gap="5">
          <Text weight="medium">Food item</Text>
          <Text>{food?.foodName || "Loading..."}</Text>
        </Flex>
        <Flex gap="5">
          <Link href={"/dashboard/nutrition/add/" + params.id}>
            <CustomButton type="submit" name="Edit Food item" color="blue" />
          </Link>
          <AlertDialog.Root>
            <AlertDialog.Trigger>
              <Button
                color="red"
                type="submit"
                className="hover:cursor-pointer"
              >
                Delete Food item
              </Button>
            </AlertDialog.Trigger>
            <AlertDialog.Content maxWidth="450px">
              <AlertDialog.Title>Confirm Delete</AlertDialog.Title>

              <AlertDialog.Description size="2">
                Are you sure you want to delete this food item? This action
                cannot be undone, and the food item will be permanently removed
                from the database.
              </AlertDialog.Description>

              <Flex gap="3" mt="4" justify="end">
                <AlertDialog.Cancel>
                  <Button variant="soft" color="gray">
                    Cancel
                  </Button>
                </AlertDialog.Cancel>
                <AlertDialog.Action>
                  <Button
                    variant="solid"
                    color="red"
                    onClick={() => deleteFood(params.id)}
                  >
                    Delete Food item
                  </Button>
                </AlertDialog.Action>
              </Flex>
            </AlertDialog.Content>
          </AlertDialog.Root>
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

export const nutritions = [
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
      { title: "Vitamin K", key: "vitaminKUg" },
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

export default FoodInfo;
