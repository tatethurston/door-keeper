import React, { useContext } from "react";
import { Sidebar, Menu, Icon, SidebarProps } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { AppRoute } from "src/utils/routes";
import { APIRoute, API } from "src/utils/api";
import { UserContext } from "src/utils/user-context";

interface SideNavProps extends SidebarProps {}

function useLogout(): () => void {
  const { setUser } = useContext(UserContext);

  return async () => {
    await API.get(APIRoute.Logout);
    setUser(undefined);
  };
}

export const SideNav: React.FC<SideNavProps> = props => {
  const logout = useLogout();

  return (
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
      <Menu.Item as={Link} to={AppRoute.Activity}>
        <Icon name="clipboard list" />
        Activity Log
      </Menu.Item>
      <Menu.Item as={Link} to={AppRoute.Keys}>
        <Icon name="key" />
        Keys
      </Menu.Item>
      <Menu.Item as={Link} to={AppRoute.Doors}>
        <Icon name="building" />
        Doors
      </Menu.Item>
      <Menu.Item as="a" onClick={logout}>
        <Icon name="log out" />
        Log Out
      </Menu.Item>
    </Sidebar>
  );
};
