"use client";
import { PureComponent } from "react";
import {
  Bar,
  BarChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

const data = [
  { name: "0 - 200", uv: 490, pv: 2400, amt: 2400 },
  { name: "200 - 400", uv: 1224, pv: 1398, amt: 2210 },
  { name: "400 - 600", uv: 24480, pv: 9800, amt: 2290 },
  { name: "600 - 800", uv: 48960, pv: 3908, amt: 2000 },
  { name: "800 - 1000", uv: 42840, pv: 4800, amt: 2181 },
  { name: "1000 - 1200", uv: 12240, pv: 3800, amt: 2500 },
  { name: "1200 - 1400", uv: 24480, pv: 4300, amt: 2100 },
  { name: "1400 - 1600", uv: 1224, pv: 1398, amt: 2210 },
  { name: "1600 - 1800", uv: 14688, pv: 9800, amt: 2290 },
  { name: "1800 - 2000", uv: 12240, pv: 3908, amt: 2000 },
  { name: "2000 - 2200", uv: 11016, pv: 4800, amt: 2181 },
  { name: "2200 - 2400", uv: 4896, pv: 3800, amt: 2500 },
  { name: "2400 - 2600", uv: 1224, pv: 4300, amt: 2100 },
];

export default class Example extends PureComponent {
  render() {
    return (
      <div style={{ width: "100%", height: 400 }}>
        <h2 style={{ textAlign: "center", marginBottom: 20, color: "#4a4a4a" }}>
          Meal Price Variation
        </h2>
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={data}>
            <XAxis
              dataKey="name"
              label={{
                value: "Price Range",
                position: "insideBottom",
                offset: -5, // Adds extra space between the label and the axis
                style: { fill: "#555555", fontSize: 14 }, // Changes color and size of the label
              }}
              tick={{ fill: "#111111", fontSize: 12 }} // Changes color and size of tick labels
            />
            <YAxis
              label={{
                value: "Price (LKR)",
                angle: -90,
                position: "insideLeft",
                offset: 10, // Adds extra space between the label and the axis
                style: { fill: "#555555", fontSize: 14 }, // Changes color and size of the label
              }}
              tick={{ fill: "#111111", fontSize: 12 }} // Changes color and size of tick labels
            />
            <Tooltip />
            <Bar dataKey="uv" fill="#8884d8" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    );
  }
}
