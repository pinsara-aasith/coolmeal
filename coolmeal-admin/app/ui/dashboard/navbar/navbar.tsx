"use client";
import { Flex, Text, TextField } from "@radix-ui/themes";
import { usePathname } from "next/navigation";
import { IoIosNotifications, IoIosSearch } from "react-icons/io";
import { MdMessage } from "react-icons/md";

const Navbar = () => {
  const path = usePathname();
  return (
    <Flex align="center" justify="between" p="4" className="bg-slate-100 ml-5">
      <Text>{path.split("/").pop()?.toUpperCase()}</Text>
      <Flex align="center" gap="3">
        <TextField.Root placeholder="Search">
          <TextField.Slot>
            <IoIosSearch height="15" width="16" />
          </TextField.Slot>
        </TextField.Root>
        <MdMessage />
        <IoIosNotifications />
      </Flex>
    </Flex>
  );
};

export default Navbar;
