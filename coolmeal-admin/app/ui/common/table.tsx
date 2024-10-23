import React from "react";

interface TableColumn {
  header: string;
  accessor: string;
  className?: string;
}

interface TableProps {
  columns: TableColumn[];
  data: Record<string, any>[];
}

const Table: React.FC<TableProps> = ({ columns, data }) => {
  return (
    <div className="relative overflow-x-auto h-full shadow-md sm:rounded-lg ">
      <table className="w-full text-sm text-left rtl:text-right">
        <thead className="text-xs uppercase bg-gray-50 dark:bg-gray-700">
          <tr>
            {columns.map((column) => (
              <th
                key={column.accessor}
                scope="col"
                className="px-6 py-3 sticky top-0 bg-gray-50 dark:bg-gray-700"
              >
                {column.header}
              </th>
            ))}
          </tr>
        </thead>
        <tbody className="overflow-y-scroll">
          {data.map((row, index) => (
            <tr
              key={index}
              className={`bg-white border-b dark:bg-gray-800 dark:border-gray-700 ${
                index % 2 === 0 ? "" : "dark:bg-gray-800"
              }`}
            >
              {columns.map((column) => (
                <td
                  key={column.accessor}
                  className={`px-6 py-4 ${column.className}`}
                >
                  {column.accessor === "action" ? (
                    <a className="font-medium hover:underline">
                      {row[column.accessor]}
                    </a>
                  ) : (
                    row[column.accessor]
                  )}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Table;
