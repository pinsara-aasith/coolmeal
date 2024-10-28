import NutritionTable from "@/app/dashboard/nutrition/nutritionTable";
import CustomButton from "@/component/CustomButton";
import Link from "next/link";
import { Suspense } from "react";

const Nutritions = () => {
  return (
    <Suspense>
      <div className="mr-5">
        <Link href="/dashboard/nutrition/add">
          <div className="m-5">
            <CustomButton color="red" name="Add new food item" />
          </div>
        </Link>
        <NutritionTable />
      </div>
    </Suspense>
  );
};

export default Nutritions;
