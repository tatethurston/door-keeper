import React, { useContext } from "react";
import { Login } from "src/pages/Login";
import { UserContext } from "src/utils/user-context";

interface RequireLoginProps {
  children: JSX.Element;
}

export const RequireLogin: React.FC<RequireLoginProps> = ({ children }) => {
  const { user } = useContext(UserContext);
  const loggedIn = user !== undefined;

  return !loggedIn ? <Login /> : children;
};
