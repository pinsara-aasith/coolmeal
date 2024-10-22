import React from "react";
import Sidebar from "@/app/ui/dashboard/sidebar/sidebar";
import Navbar from "../ui/dashboard/navbar/navbar";
import { Grid } from "@radix-ui/themes";

import contentbg from "@/public/contentbg.png";

const layout = ({ children }: Readonly<{ children: React.ReactNode }>) => {
  return (
    <div className="min-h-screen flex">
      {" "}
      {/* Full screen height and flexbox layout */}
      <div className="w-[20%] bg-slate-100 h-screen">
        {" "}
        {/* Sidebar with full screen height */}
        <Sidebar />
      </div>
      <div className="w-[80%] flex flex-col">
        {" "}
        {/* Main content container */}
        <Navbar />
        <div className="flex-grow bg-cover" style={{ backgroundImage: `url(${contentbg.src})`}}>{children}</div>
      </div>
    </div>
  );
};

export default layout;
