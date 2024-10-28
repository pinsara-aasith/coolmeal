import CustomButton from "@/component/CustomButton";
import Link from "next/link";
import { Suspense } from "react";
import MealPlansTable from "./mealPlanTable";
import { MealPlanDialogWithTriggerButton } from "./mealPlanDialog";

const MealPlans = () => {
  return (
    <Suspense>
      <div className="mr-5">
        <div className="m-5">
          <MealPlanDialogWithTriggerButton triggerLabel="Add New Meal Plan" />
        </div>

        <MealPlansTable />
      </div>
    </Suspense>
  );
};

export default MealPlans;
