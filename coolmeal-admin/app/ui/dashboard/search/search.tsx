"use client";
import { Box, TextField } from "@radix-ui/themes";
import { usePathname, useSearchParams } from "next/navigation";
import { useRouter } from "next/navigation";
import React from "react";
import { IoIosSearch } from "react-icons/io";

interface Props {
  placeholder: string;
}

const Search = ({ placeholder }: Props) => {
  const searchParams = useSearchParams();
  const { replace } = useRouter();
  const pathname = usePathname();

  const handleSearch = (e: React.ChangeEvent<HTMLInputElement>) => {
    const params = new URLSearchParams(searchParams);
    if (e.target.value) params.set("q", e.target.value);
    else params.delete("q");

    replace(`${pathname}?${params}`);
  };
  return (
    <Box maxWidth="250px">
      <TextField.Root placeholder={placeholder} onChange={handleSearch}>
        <TextField.Slot>
          <IoIosSearch height="16" width="16" />
        </TextField.Slot>
      </TextField.Root>
    </Box>
  );
};

export default Search;
