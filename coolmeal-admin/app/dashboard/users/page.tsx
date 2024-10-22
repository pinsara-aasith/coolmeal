import React, { Suspense } from "react";
import UserTable from "./usertable";

const Users = () => {
  return (
    <Suspense>
      <div data-testid="user-table">
        <UserTable />
      </div>
    </Suspense>
  );
};

export default Users;
