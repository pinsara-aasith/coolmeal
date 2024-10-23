"use client";
import CustomButton from "@/component/CustomButton";
import { Flex, Text, TextField } from "@radix-ui/themes";
import axios from "axios";
import { useRouter } from "next/navigation";
import React, { useEffect, useState } from "react";

interface Foods {
  foodName: string;
  foodId: string;
  foodCode: string;
  priceCode: string;
  energyKcal: number;
  proteinG: number;
  totalFatG: number;
  carbohydratesG: number;
  totalDietaryFibreG: string;
  freeSugarG: number;
  starchG: number;
  vitaminKUg: string;
  vitaminDUg: string;
  vitaminAUg: string;
  vitaminEMg: string;
  calciumMg: number;
  phosphorusMg: number;
  magnesiumMg: number;
  sodiumMg: number;
  potassiumMg: number;
  monounsaturatedFattyAcidsMg: string;
  polyunsaturatedFattyAcidsMg: string;
  saturatedFattyAcidsMg: number;
}

interface Props {
  params?: {
    id: string;
  };
}
interface FoodName {
  foodName: string;
}

const FoodForm = ({ params }: Props) => {
  const [food, setFood] = useState<Foods | null>(null);
  const [foodName, setFoodName] = useState<FoodName[]>([]);
  const router = useRouter();
  // console.log("foods", foodName);

  // Fetch food data when component mounts
  useEffect(() => {
    const fetchFood = async () => {
      const id = params?.id;
      try {
        const response = await axios.get("/api/dashboard/foods/" + id);
        setFood(response.data); // Set the fetched data
      } catch (error) {
        console.error("Error fetching food details: ", error);
      }
    };

    if (params?.id) {
      fetchFood();
    }
  }, [params?.id]);

  useEffect(() => {
    const fetchFoodList = async () => {
      try {
        const response = await axios.get("/api/dashboard/foods");
        const foodName = response.data.map(
          (food: { foodName: string }) => food.foodName
        );
        setFoodName(foodName);
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };

    fetchFoodList();
  }, []);

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const data = Object.fromEntries(formData.entries());
    console.log("Form data:", data);

    try {
      const response = await axios.post("/api/dashboard/foods", data);
      console.log("Response from server:", response.data);
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  const handleUpdate = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const data = Object.fromEntries(formData.entries());
    console.log("Form data:", data);

    try {
      const response = await axios.patch(
        "/api/dashboard/foods/" + params?.id,
        data
      );
      router.push("/dashboard/nutrition/" + params?.id);
      console.log("Response from server:", response.data);
    } catch (error) {
      console.error("Error updating form:", error);
    }
  };

  return (
    <div className="ml-5 mt-5 mr-5">
      <form onSubmit={params?.id ? handleUpdate : handleSubmit}>
        <Flex align="center" gap="5" className="mb-5 " justify="between">
          <Flex wrap="wrap" gap="5">
            <Text>Food Ingredients</Text>

            <TextField.Root
              defaultValue={food?.foodName || ""}
              placeholder="Enter name of food"
              name="foodName"
              required
            >
              <TextField.Slot />
            </TextField.Root>
          </Flex>
          <CustomButton
            color="blue"
            name={params?.id ? "Update food" : "Add food"}
            type="submit"
          />
        </Flex>

        {nutritions.map((nutrition) => (
          <div key={nutrition.title} className="mb-6">
            <Text weight="bold" className="mb-2">
              {nutrition.title}
            </Text>
            {nutrition.list.map((item, index) => {
              if (index % 2 === 0) {
                return (
                  <Flex key={item.title} align="center" className="mb-3 gap-5">
                    <Flex className="w-1/2 items-center gap-5">
                      <Text className="w-[150px]">{item.title}</Text>
                      <TextField.Root
                        defaultValue={
                          food ? String(food[item.key as keyof Foods]) : ""
                        }
                        className="flex-grow"
                        placeholder={item.placeholder}
                        name={item.name} // Add name attribute
                      >
                        <TextField.Slot />
                      </TextField.Root>
                    </Flex>
                    {nutrition.list[index + 1] && (
                      <Flex className="w-1/2 items-center gap-5">
                        <Text className="w-[150px]">
                          {nutrition.list[index + 1].title}
                        </Text>
                        <TextField.Root
                          defaultValue={
                            food
                              ? String(
                                  food[
                                    nutrition.list[index + 1].key as keyof Foods
                                  ]
                                )
                              : ""
                          }
                          className="flex-grow"
                          placeholder={nutrition.list[index + 1].placeholder}
                          name={nutrition.list[index + 1].name} // Add name attribute
                        >
                          <TextField.Slot />
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

export const nutritions = [
  {
    title: "Macronutrients",
    list: [
      {
        title: "Energy",
        placeholder: "add energy in Kcal",
        key: "energyKcal",
        name: "energyKcal",
      },
      {
        title: "Protein",
        placeholder: "add protein in g",
        key: "proteinG",
        name: "proteinG",
      },
      {
        title: "Total fat",
        placeholder: "add total fat in g",
        key: "totalFatG",
        name: "totalFatG",
      },
      {
        title: "Carbohydrates",
        placeholder: "add carbohydrate in g",
        key: "carbohydratesG",
        name: "carbohydratesG",
      },
      {
        title: "Total Dietary Fibre",
        placeholder: "add dietary fibre in g",
        key: "totalDietaryFibreG",
        name: "totalDietaryFibreG",
      },
      {
        title: "Free sugar",
        placeholder: "add free sugar in g",
        key: "freeSugarG",
        name: "freeSugarG",
      },
      {
        title: "Starch",
        placeholder: "add starch in g",
        key: "starchG",
        name: "starchG",
      },
    ],
  },
  {
    title: "Vitamins",
    list: [
      {
        title: "Vitamin A",
        placeholder: "add vitamin A in µg",
        key: "vitaminAUg",
        name: "vitaminAUg",
      },
      {
        title: "Vitamin D",
        placeholder: "add vitamin D in µg",
        key: "vitaminDUg",
        name: "vitaminDUg",
      },
      {
        title: "Vitamin K",
        placeholder: "add vitamin K in µg",
        key: "vitaminKUg",
        name: "vitaminKUg",
      },
      {
        title: "Vitamin E",
        placeholder: "add vitamin E in mg",
        key: "vitaminEMg",
        name: "vitaminEMg",
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
        name: "calciumMg",
      },
      {
        title: "Phosphorus",
        placeholder: "add phosphorus in mg",
        key: "phosphorusMg",
        name: "phosphorusMg",
      },
      {
        title: "Magnesium",
        placeholder: "add magnesium in mg",
        key: "magnesiumMg",
        name: "magnesiumMg",
      },
      {
        title: "Sodium",
        placeholder: "add sodium in mg",
        key: "sodiumMg",
        name: "sodiumMg",
      },
      {
        title: "Potassium",
        placeholder: "add potassium in mg",
        key: "potassiumMg",
        name: "potassiumMg",
      },
    ],
  },
  {
    title: "Fatty Acids",
    list: [
      {
        title: "Saturated Fatty Acids",
        placeholder: "add saturated fatty acids in mg",
        key: "saturatedFattyAcidsMg",
        name: "saturatedFattyAcidsMg",
      },
      {
        title: "Monounsaturated Fatty Acids",
        placeholder: "add monounsaturated fatty acids in mg",
        key: "monounsaturatedFattyAcidsMg",
        name: "monounsaturatedFattyAcidsMg",
      },
      {
        title: "Polyunsaturated Fatty Acids",
        placeholder: "add polyunsaturated fatty acids in mg",
        key: "polyunsaturatedFattyAcidsMg",
        name: "polyunsaturatedFattyAcidsMg",
      },
    ],
  },
];

export default FoodForm;
