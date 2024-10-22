import { Flex, Text } from "@radix-ui/themes";
import Link from "next/link";
import { usePathname } from "next/navigation";
import React from "react";

interface Props {
  item: {
    title: string;
    icon: JSX.Element;
    url: string;
  };
}

const Menulink = ({ item }: Props) => {
  const pathname = usePathname();

  return (
    <Link href={item.url}>
      <Flex
        key={item.title}
        align="center"
        gap="2"
        className={
          item.url === pathname ? "bg-slate-200 p-3.5 m-0.5 rounded-md" : "p-3.5 m-0.5 rounded-md hover:bg-slate-200"
        }
      >
        <div>{item.icon}</div>
        <Text>{item.title}</Text>
      </Flex>
    </Link>
  );
};

export default Menulink;
