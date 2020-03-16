import React from "react";
import { Menu, Dropdown } from "semantic-ui-react";

interface NavProps {
  onClick(): void;
}

export const Nav: React.FC<NavProps> = ({ onClick }) => (
  <Menu attached="top">
    <Dropdown item icon="bars" simple onClick={onClick} />
  </Menu>
);
