import NutritionTable from "@/app/ui/food/nutritionTable";
import { Button } from "@radix-ui/themes";
import Link from "next/link";
import React from "react";

const Nutritions = () => {
  return (
    <div>
      <Link href="/dashboard/nutrition/add">
        <div className="m-5 ">
          <Button>Add new food item</Button>
        </div>
      </Link>
      <NutritionTable />
    </div>
  );
};

export default Nutritions;
