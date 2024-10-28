import { Suspense } from "react";
import { MealItemDialogWithTriggerButton } from "./mealItemDialog";
import MealItemsTable from "./mealItemsTable";

const MealItems = () => {
  return (
    <Suspense>
      <div className="mr-5">
        <div className="m-5">
          <MealItemDialogWithTriggerButton triggerLabel="Add New Meal Item" />
        </div>

        <MealItemsTable />
      </div>
    </Suspense>
  );
};

export default MealItems;
