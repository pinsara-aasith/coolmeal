"use client";
import { Avatar, Button, Flex, Text } from "@radix-ui/themes";
import { FaNutritionix, FaUserAlt } from "react-icons/fa";
import { FaArrowTrendUp } from "react-icons/fa6";
import { GiArtificialIntelligence } from "react-icons/gi";
import { IoIosSettings } from "react-icons/io";
import { MdDashboard, MdNoMeals } from "react-icons/md";
import { RiLogoutBoxFill } from "react-icons/ri";
import Menulink from "./menulink/menulink";
import useToast from "@/hooks/use-snackbar";
import { useRouter } from "next/navigation";
import { logout } from "@/lib/auth";

const Sidebar = (props: any) => {
  const menuItems = [
    {
      title: "pages",
      list: [
        { title: "Dashboard", url: "/dashboard", icon: <MdDashboard /> },
        { title: "Users", url: "/dashboard/users", icon: <FaUserAlt /> },
        {
          title: "Food item",
          url: "/dashboard/nutrition",
          icon: <FaNutritionix />,
        },
        { title: "Meals", url: "/dashboard/meals", icon: <MdNoMeals /> },
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
    {
      title: "User",
      list: [
        {
          title: "Settings",
          url: "/dashboard/settting",
          icon: <IoIosSettings />,
        },
      ],
    },
  ];

  const toast = useToast();
  const router = useRouter();

  return (
    <div className="m-5">
      <Flex align="center" gap="4" className="mb-5">
        <Avatar fallback="" radius="full" size="5" />
        <Flex direction="column">
          <Text>Admin</Text>
          <Text>Administrator</Text>
        </Flex>
      </Flex>
      {menuItems.map((item) => (
        <div key={item.title} className="mb-5">
          <div className="mb-2">{item.title}</div>
          <Flex direction="column">
            {item.list.map((subItem) => (
              <Menulink key={subItem.title} item={subItem} />
            ))}
          </Flex>
        </div>
      ))}
      <form action={logout}>
        <Button type="submit">Logout</Button>
      </form>
    </div>
  );
};

export default Sidebar;
