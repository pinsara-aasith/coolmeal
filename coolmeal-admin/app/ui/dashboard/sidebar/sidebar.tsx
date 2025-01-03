"use client";
import { Avatar, Button, Flex, Text } from "@radix-ui/themes";
import { FaNutritionix, FaRobot, FaUser, FaUserAlt } from "react-icons/fa";
import { FaArrowTrendUp, FaUserTag } from "react-icons/fa6";
import { GiArtificialIntelligence, GiFoodChain } from "react-icons/gi";
import { IoIosSettings } from "react-icons/io";
import { MdDashboard, MdNoMeals, MdFoodBank, MdLibraryBooks } from "react-icons/md";
import { RiLogoutBoxFill } from "react-icons/ri";
import Menulink from "./menulink/menulink";
import useToast from "@/hooks/use-snackbar";
import { useRouter } from "next/navigation";

import coolAdminPng from "@/public/cool-admin.png";

const Sidebar = (props: any) => {
  const menuItems = [
    {
      title: "Manage",
      list: [
        { title: "Dashboard", url: "/dashboard", icon: <MdDashboard /> },
        { title: "Users", url: "/dashboard/users", icon: <FaUserAlt /> },
        {
          title: "Food Ingredients",
          url: "/dashboard/nutrition",
          icon: <FaNutritionix />,
        },
        { title: "Meal Items", url: "/dashboard/mealitems", icon: <MdFoodBank /> },
        { title: "Meals", url: "/dashboard/meals", icon: <MdNoMeals /> },
        { title: "Meal Plans", url: "/dashboard/mealplans", icon: <FaUserTag /> },
        { title: "Chatbot", url: "/dashboard/chatbot", icon: <FaRobot /> },
        
      ],
    },
    {
      title: "Analytics",
      list: [
        {
          title: "Model",
          url: "/dashboard/model",
          icon: <GiArtificialIntelligence />,
        },
        { title: "Trend", url: "/dashboard/trend", icon: <FaArrowTrendUp /> },
      ],
    },
    // {
    //   title: "User",
    //   list: [
    //     {
    //       title: "Settings",
    //       url: "/dashboard/settting",
    //       icon: <IoIosSettings />,
    //     },
    //   ],
    // },
  ];

  const toast = useToast();
  const router = useRouter();

  return (

    <div className="m-5">

      <Flex align="center" gap="4" className="mb-5">
        <Avatar fallback="" radius="full" size="5" src={coolAdminPng.src}/>
        <Flex direction="column">
          <Text className="font-bold">Cool Admin</Text>
        </Flex>
      </Flex>
      {menuItems.map((item) => (
        <div key={item.title} className="mb-5">
          <div className="mb-2 font-bold">{item.title}</div>
          <Flex direction="column">
            {item.list.map((subItem) => (
              <Menulink key={subItem.title} item={subItem} />
            ))}
          </Flex>
        </div>
      ))}

    </div>
  );
};

export default Sidebar;
