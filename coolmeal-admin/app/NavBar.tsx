"use client";
import { Avatar, Flex, Grid } from "@radix-ui/themes";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import classnames from "classnames";

const NavBar = () => {
  return (
    <Flex
      className="pl-5 pr-5 pt-3 mb-5"
      gap="5"
      align="center"
      justify="between"
    >
      <Image
        src="/Admin.png"
        alt="Logo"
        width={150}
        height={100}
        className="cursor-pointer"
      />
      <Flex gap="5">
        <NavLink />
      </Flex>
      <Avatar fallback={""} radius="full" size="5" />
    </Flex>
  );
};

const NavLink = () => {
  const currentPath = usePathname();
  const links = [
    {
      label: "Dashboard",
      href: "/",
    },
    {
      label: "Overview",
      href: "/overview",
    },
    {
      label: "Manage",
      href: "/manage",
    },
  ];
  return (
    <ul className="flex space-x-6">
      {links.map((link) => (
        <li key={link.href}>
          <Link
            className={classnames({
              "nav-link": true,
              "!text-zinc-900": link.href === currentPath,
            })}
            href={link.href}
          >
            {link.label}
          </Link>
        </li>
      ))}
    </ul>
  );
};
export default NavBar;
