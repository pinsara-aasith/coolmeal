import { Button } from "@radix-ui/themes";
import React from "react";

interface Props {
  color?: any;
  name?: string;
  type?: any;
}

const CustomButton = ({ color, name, type }: Props) => {
  return (
    <Button className="hover:cursor-pointer" color={color} type={type}>
      {name}
    </Button>
  );
};

export default CustomButton;
