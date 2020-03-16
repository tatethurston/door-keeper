import React from "react";
import { Sidebar, Menu, Icon, SidebarProps } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { AppURL } from "src/utils/routes";

interface SideNavProps extends SidebarProps {}

export const SideNav: React.FC<SideNavProps> = props => (
  <Sidebar
    as={Menu}
    animation="overlay"
    direction="left"
    icon="labeled"
    inverted
    vertical
    width="thin"
    {...props}
  >
    <Link to={AppURL.Activity}>
      <Menu.Item as="a">
        <Icon name="clipboard list" />
        Activity Log
      </Menu.Item>
    </Link>
    <Link to={AppURL.Keys}>
      <Menu.Item as="a">
        <Icon name="key" />
        Keys
      </Menu.Item>
    </Link>
    <Link to={AppURL.Doors}>
      <Menu.Item as="a">
        <Icon name="building" />
        Doors
      </Menu.Item>
    </Link>
  </Sidebar>
);
