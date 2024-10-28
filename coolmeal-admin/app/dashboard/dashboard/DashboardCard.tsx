import { Box, Card, Flex, Text } from "@radix-ui/themes";
import Image, { StaticImageData } from "next/image";

interface Props {
  count: number;
  title: string;
  img: StaticImageData;
  color: string;
}

const DashboardCard = ({ count, title, img, color }: Props) => {
  return (
    <Box>
      <Card className={color}>
        <Flex gap="9" align="center" className="p-2">
          <Flex className="mr-9" direction="column">
            <Text as="div" size="7" weight="bold">
              {count}
            </Text>
            <Text as="div" size="4" color="gray">
              {title}
            </Text>
          </Flex>
          <Image src={img} alt="" width={40} />
        </Flex>
      </Card>
    </Box>
  );
};

export default DashboardCard;
