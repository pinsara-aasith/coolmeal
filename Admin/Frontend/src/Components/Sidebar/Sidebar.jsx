import React from "react";
import { Link } from "react-router-dom";
import logo from "../../Assets/logo.png";

import "./Sidebar.css";

const Sidebar = () => {
  return (
    <div className="sidebar">
      <div className="sidebar-logo">
        <img src={logo} className="logo" />
      </div>

      <Link to={"./addproduct"} style={{ textDecoration: "none" }}>
        <div className="sidebar-item">
          <p>Dashboard</p>
        </div>
      </Link>
      <Link to={"./listproduct"} style={{ textDecoration: "none" }}>
        <div className="sidebar-item">
          <p>Users</p>
        </div>
      </Link>
      <Link to={"./orderlist"} style={{ textDecoration: "none" }}>
        <div className="sidebar-item">
          <p>Analysis</p>
        </div>
      </Link>
    </div>
  );
};

export default Sidebar;
