import NutritionTable from "@/app/ui/food/nutritionTable";
import CustomButton from "@/component/CustomButton";
import Link from "next/link";

const Nutritions = () => {
  return (
    <div>
      <Link href="/dashboard/nutrition/add">
        <div className="m-5">
          <CustomButton color="red" name="Add new food item" />
        </div>
      </Link>
      <NutritionTable />
    </div>
  );
};

export default Nutritions;
