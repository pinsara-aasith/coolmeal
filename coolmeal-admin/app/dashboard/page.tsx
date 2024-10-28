import Meal from "@/public/meal.png";
import User from "@/public/user.png";
import { Flex } from "@radix-ui/themes";
import Charts from "./dashboard/Charts";
import DashboardCard from "./dashboard/DashboardCard";
import DashboardGrid from "./dashboard/DashboardGrid";

const Dashboard = () => {
  return (
    <div className="m-3">
      <Flex gap="5">
        <DashboardCard
          count={500}
          title="User"
          img={User}
          color="bg-green-400"
        />
        <DashboardCard
          count={500}
          title="Meal Plans"
          img={Meal}
          color="bg-blue-400"
        />
      </Flex>
      <DashboardGrid />
    </div>
  );
};

export default Dashboard;
