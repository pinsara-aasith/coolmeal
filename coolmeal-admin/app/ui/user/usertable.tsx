"use client";

import { Badge, Card, Link } from "@radix-ui/themes";
import axios from "axios";
import { useEffect, useState } from "react";
import { useSearchParams } from "next/navigation"; // Import this to get the search query
import Search from "../dashboard/search/search";

interface User {
  id: string;
  name: string;
  email: string;
  gender: string;
}

const UserTable = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [filteredUsers, setFilteredUsers] = useState<User[]>([]); // New state for filtered users
  const searchParams = useSearchParams(); // Get search params

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("/api/dashboard/users");
        setUsers(response.data); // Set the users data
      } catch (error) {
        console.error("Error fetching user details: ", error);
      }
    };

    fetchUsers();
  }, []);

  useEffect(() => {
    const query = searchParams.get("q") || ""; // Get the search query
    const filtered = users.filter((user) =>
      user.name.toLowerCase().includes(query.toLowerCase())
    );
    setFilteredUsers(filtered); // Update filtered users
  }, [searchParams, users]); // Re-run when search query or users data changes

  return (
    <Card className="ml-5 mt-5">
      <Search placeholder="search for user" />
      <div className="overflow-x-auto">
        {" "}
        {/* Enable horizontal scrolling */}
        <div className="max-h-80 overflow-y-auto">
          {" "}
          {/* Enable vertical scrolling with limited height */}
          <table className="table-auto w-full">
            <thead>
              <tr>
                <th className="sticky left-0 bg-white z-10 p-2 text-left">
                  Name
                </th>
                <th className="p-2 text-left">Email</th>
                <th className="p-2 text-left">Gender</th>
              </tr>
            </thead>
            <tbody>
              {filteredUsers.map((user) => (
                <tr key={user.id}>
                  <td className="sticky left-0 bg-white z-10 p-2">
                    <Link href={"/dashboard/users/" + user.id}>
                      {user.name}
                    </Link>
                  </td>
                  <td className="p-2">{user.email}</td>
                  <td className="p-2">
                    <Badge
                      color={user.gender === "male" ? "blue" : "pink"}
                      variant="soft"
                      radius="full"
                    >
                      {user.gender}
                    </Badge>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </Card>
  );
};

export default UserTable;
