import React from "react";
import Example from "./dashboard/Charts";
import { Flex } from "@radix-ui/themes";

import User from "@/public/user.png";
import DashboardCard from "./dashboard/DashboardCard";
import Meal from "@/public/meal.png";

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
          color="bg-green-800"
        />
      </Flex>
      <Example />
    </div>
  );
};

export default Dashboard;
