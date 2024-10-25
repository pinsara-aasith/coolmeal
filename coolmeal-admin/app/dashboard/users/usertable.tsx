"use client";

import { Badge, Card, Link } from "@radix-ui/themes";
import axios from "axios";
import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import Search from "../../ui/dashboard/search/search";
import LoadingSkeleton from "@/app/ui/common/loadingSkeleton";
import Table from "@/app/ui/common/table";

interface User {
  id: string;
  name: string;
  email: string;
  gender: string;
}

const UserTable = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [filteredUsers, setFilteredUsers] = useState<User[]>([]);
  const searchParams = useSearchParams();
  const [loading, setLoading] = useState<boolean>(true);

  const fetchUsers = async () => {
    try {
      const response = await axios.get("/api/dashboard/users");
      setUsers(response.data);
      console.log(response.data)
    } catch (error) {
      console.error("Error fetching user details: ", error);
    }
  };

  useEffect(() => {
    setLoading(true);
    fetchUsers().finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    const query = searchParams.get("q") || "";
    const filtered = users.filter((user) =>
      user.name.toLowerCase().includes(query.toLowerCase())
    );
    setFilteredUsers(filtered);
  }, [searchParams, users]);

  // Define table columns
  const columns = [
    {
      header: "User Id",
      accessor: "id",
    },
    {
      header: "Name",
      accessor: "name",
    },
    {
      header: "Email",
      accessor: "email",
      className: 'font-bold'
    },
    {
      header: "Gender",
      accessor: "gender",
    },
    {
      header: "Age",
      accessor: "age",
    },
    {
      header: "Weight",
      accessor: "weight",
    },
    {
      header: "Fitness Goals",
      accessor: "fitnessGoals",
    },{
      header: "Exercise Level",
      accessor: "execiseLevel",
      className: 'font-semibold'
    },
  ];

  // Map the user data to match the Table component's expected format
  const tableData = filteredUsers.map((user) => ({
    ...user,
    id: (
      <Link href={`/dashboard/users/${user.id}`} className="text-blue-600 hover:underline font-bold">
        {user.id.substring(0,7).toUpperCase()}
      </Link>
    ),
    gender: (
      <Badge
        color={user.gender === "male" ? "blue" : "pink"}
        variant="soft"
        radius="full"
        className="capitalize"
      >
        {user.gender}
      </Badge>
    ),
  }));

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="Search for user" />
      <div className="overflow-x-auto mt-5">
        <div className="overflow-y-auto">
          {loading ? (
            <LoadingSkeleton />
          ) : (
            <Table columns={columns} data={tableData} />
          )}
        </div>
      </div>
    </Card>
  );
};

export default UserTable;
