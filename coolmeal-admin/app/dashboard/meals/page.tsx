import CustomButton from "@/component/CustomButton";
import Link from "next/link";
import { Suspense } from "react";
import MealsTable from "./mealTable";
import { MealDialogWithTriggerButton } from "./mealDialog";

const Meals = () => {
  return (
    <Suspense>
      <div className="mr-5">
        <div className="m-5">
          <MealDialogWithTriggerButton triggerLabel="Add New Meal " />
        </div>

        <MealsTable />
      </div>
    </Suspense>
  );
};

export default Meals;
