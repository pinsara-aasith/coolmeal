import CustomButton from "@/component/CustomButton";
import Link from "next/link";
import { Suspense } from 'react'
import MealItemsTable from "./mealItemsTable";
import { MealItemDialogWithTriggerButton } from "./mealItemDialog";

const MealItems = () => {
  return (
    <Suspense>
      <div>
          <div className="m-5">
            <MealItemDialogWithTriggerButton triggerLabel="Add New Meal Item"/>
          </div>

        <MealItemsTable />
      </div>
    </Suspense>
  );
};

export default MealItems;
