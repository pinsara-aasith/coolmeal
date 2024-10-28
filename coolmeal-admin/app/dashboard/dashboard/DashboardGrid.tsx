import { Card, Flex, Grid, Table, Text } from "@radix-ui/themes";
import React from "react";
import Example from "./Charts";

const DashboardGrid = () => {
  return (
    <Grid
      columns="80% 20%"
      gap="2"
      rows="repeat(1, 500px)"
      width="auto"
      className="mt-5 mr-5"
    >
      <Card>
        <Example />
      </Card>
      <div>
        <Card className="align-middle">
          <Table.Root>
            <Table.Header>
              <Table.Row>
                <Table.ColumnHeaderCell>Name</Table.ColumnHeaderCell>
                <Table.ColumnHeaderCell>Gender</Table.ColumnHeaderCell>
              </Table.Row>
            </Table.Header>

            <Table.Body>
              <Table.Row>
                <Table.RowHeaderCell>Danilo Sousa</Table.RowHeaderCell>
                <Table.Cell>danilo@example.com</Table.Cell>
              </Table.Row>
            </Table.Body>
          </Table.Root>
        </Card>
      </div>
    </Grid>
  );
};

export default DashboardGrid;
