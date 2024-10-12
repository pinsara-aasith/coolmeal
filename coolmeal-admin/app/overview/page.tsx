import { Avatar, Box, Card, Flex, Text } from "@radix-ui/themes";
import Link from "next/link";
import React from "react";

const Overview = () => {
  const cards = [
    {
      name: "Users",
      href: "/overview/users",
    },
    {
      name: "Meals",
      href: "/overview/meals",
    },
    {
      name: "Prices",
      href: "/overview/prices",
    },
    {
      name: "Ingredient",
      href: "/overview/ingredient",
    },
  ];
  return (
    <Flex>
      {cards.map((card) => (
        <Flex className="ml-5" key={card.href}>
          <Box maxWidth="240px">
            <Link href={card.href}>
              <Card>
                <Flex gap="3" align="center">
                  <Avatar size="3" radius="full" fallback="T" />
                  <Box>
                    <Text as="div" size="2" weight="bold">
                      {card.name}
                    </Text>
                  </Box>
                </Flex>
              </Card>
            </Link>
          </Box>
        </Flex>
      ))}
    </Flex>
  );
};

export default Overview;
