import FoodForm from "@/app/ui/food/foodForm";
import React from "react";

interface Props {
  params: {
    id: string;
  };
}

const EditFoodItem = ({ params }: Props) => {
  return (
    <div>
      <FoodForm params={params} />
    </div>
  );
};

export default EditFoodItem;
