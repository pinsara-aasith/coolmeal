"use client";

import { Badge, DataList, Link, Text } from "@radix-ui/themes";
import axios from "axios";
import { useEffect, useState } from "react";

interface Props {
  params: {
    id: string;
  };
}
interface User {
  name: string;
  email: string;
  gender: string;
  age: number;
  anyAllergies: string;
  exerciseLevel: string;
  fitnessGoals: string;
  healthConcerns: string;
  height: number;
  weight: number;
}

const UserProfile = ({ params }: Props) => {
  const [user, setUser] = useState<User | null>(null); // Change to a single user object
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("/api/dashboard/users/" + params.id);
        setUser(response.data); // Set the correct data
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };

    fetchUsers();
  }, [params]);
  return (
    <DataList.Root>
      <DataList.Item>
        <DataList.Label minWidth="88px">Name</DataList.Label>
        <DataList.Value>{user?.name}</DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">Email</DataList.Label>
        <DataList.Value>
          <Link href={"mailto:" + user?.email}>{user?.email}</Link>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item align="center">
        <DataList.Label minWidth="88px">Gender</DataList.Label>
        <DataList.Value>
          <Badge
            color={user?.gender === "male" ? "blue" : "pink"}
            variant="soft"
            radius="full"
          >
            {user?.gender}
          </Badge>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">Age</DataList.Label>
        <DataList.Value>
          <Text>{user?.age}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">Height</DataList.Label>
        <DataList.Value>
          <Text>{user?.height}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">Weight</DataList.Label>
        <DataList.Value>
          <Text>{user?.weight}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">Allergies</DataList.Label>
        <DataList.Value>
          <Text>{user?.anyAllergies}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">ExerciseLevel</DataList.Label>
        <DataList.Value>
          <Text>{user?.exerciseLevel}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">FitnessGoals</DataList.Label>
        <DataList.Value>
          <Text>{user?.fitnessGoals}</Text>
        </DataList.Value>
      </DataList.Item>
      <DataList.Item>
        <DataList.Label minWidth="88px">HealthConcerns</DataList.Label>
        <DataList.Value>
          <Text>{user?.healthConcerns}</Text>
        </DataList.Value>
      </DataList.Item>
    </DataList.Root>
  );
};

export default UserProfile;
