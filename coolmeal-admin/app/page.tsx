"use client";
import React, { useState } from "react";
import * as Popover from "@radix-ui/react-popover";

const SearchDropdown = () => {
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredOptions, setFilteredOptions] = useState<string[]>([]);
  const [showDropdown, setShowDropdown] = useState(false);

  // Options list
  const options = [
    "Google Meet",
    "Fidenz Technologies",
    "Ncinga",
    "Javascript Online Compiler",
    "AizenIT",
    "1 Billion Tech",
    "Dollar Rate",
    "US Time",
  ];

  // Handle input change
  const handleInputChange = (e: { target: { value: string } }) => {
    const value = e.target.value.toLowerCase();
    setSearchTerm(value);

    // Filter options based on input
    const filtered = options.filter((option) =>
      option.toLowerCase().includes(value)
    );
    setFilteredOptions(filtered);

    // Show dropdown if input is not empty
    setShowDropdown(value.length > 0);
  };

  // Handle click on an option
  const handleOptionClick = (option: React.SetStateAction<string>) => {
    setSearchTerm(option);
    setShowDropdown(false); // Close dropdown after selection
  };

  return (
    <div className="relative w-64">
      <Popover.Root open={showDropdown}>
        <Popover.Trigger asChild>
          <input
            type="text"
            className="w-full px-4 py-2 text-sm border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            value={searchTerm}
            onChange={handleInputChange}
            placeholder="Search..."
            onFocus={() => setShowDropdown(true)}
          />
        </Popover.Trigger>

        <Popover.Content
          className="w-full mt-2 bg-white rounded-md shadow-lg max-h-48 overflow-y-auto"
          sideOffset={5}
          align="start"
          side="bottom"
        >
          {filteredOptions.length > 0 ? (
            <ul className="divide-y divide-gray-200">
              {filteredOptions.map((option, index) => (
                <li
                  key={index}
                  onClick={() => handleOptionClick(option)}
                  className="px-4 py-2 cursor-pointer hover:bg-gray-100"
                >
                  {option}
                </li>
              ))}
            </ul>
          ) : (
            <div className="px-4 py-2 text-gray-500">No results found</div>
          )}
        </Popover.Content>
      </Popover.Root>
    </div>
  );
};

export default SearchDropdown;
