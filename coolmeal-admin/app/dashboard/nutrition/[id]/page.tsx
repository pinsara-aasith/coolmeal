import FoodInfo from "@/app/ui/food/foodInfo";

interface Props {
  params: {
    id: string;
  };
}

const Nutritions = ({ params }: Props) => {
  return (
    <div>
      <FoodInfo params={params} />
    </div>
  );
};

export default Nutritions;
