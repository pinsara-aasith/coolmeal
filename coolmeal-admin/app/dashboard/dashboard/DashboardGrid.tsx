"use client";
import { Badge, Card, Grid, Table } from "@radix-ui/themes";
import axios from "axios";
import { useEffect, useState } from "react";
import Example from "./Charts";

interface User {
  id: string;
  name: string;
  gender: string;
}

const DashboardGrid = () => {
  const [users, setUsers] = useState<User[]>([]);
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("/api/dashboard/users");
        setUsers(response.data);
        console.log(response.data);
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };
    fetchUsers();
  }, []);

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
              {users.map((user) => (
                <Table.Row>
                  <Table.RowHeaderCell>{user.name}</Table.RowHeaderCell>
                  <Table.Cell>
                    <Badge
                      color={user.gender === "male" ? "blue" : "pink"}
                      variant="soft"
                      radius="full"
                      className="capitalize"
                    >
                      {user.gender}
                    </Badge>
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table.Body>
          </Table.Root>
        </Card>
      </div>
    </Grid>
  );
};

export default DashboardGrid;
