"use client";
import Meal from "@/public/meal.png";
import User from "@/public/user.png";
import Ingredient from "@/public/ingredient.png";
import { Flex } from "@radix-ui/themes";
import DashboardCard from "./dashboard/DashboardCard";
import DashboardGrid from "./dashboard/DashboardGrid";
import { useEffect, useState } from "react";
import axios from "axios";

const Dashboard = () => {
  const [userCount, setUserCount] = useState();
  console.log(userCount);

  useEffect(() => {
    const fetchUserCount = async () => {
      try {
        const response = await axios.get("/api/dashboard/users/count");
        setUserCount(response.data.count);
      } catch (error) {
        console.error("Error fetching user count:", error);
      }
    };

    fetchUserCount();
  }, []);
  return (
    <div className="m-3">
      <Flex gap="5">
        <DashboardCard
          count={userCount!}
          title="User"
          img={User}
          color="bg-green-400"
        />
        <DashboardCard
          count={200000}
          title="Meal Plans"
          img={Meal}
          color="bg-blue-400"
        />
        <DashboardCard
          count={300}
          title="Ingredients"
          img={Ingredient}
          color="bg-red-400"
        />
      </Flex>
      <DashboardGrid />
    </div>
  );
};

export default Dashboard;
