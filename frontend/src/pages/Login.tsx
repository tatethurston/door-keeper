import React from "react";
import "./Login.css";
import { Button } from "semantic-ui-react";
import { APIRoute } from "src/utils/api";

export const Login: React.FC = () => {
  return (
    <div className="login-page">
      <a href={APIRoute.Login}>
        <Button color="red" content="Login with Google" icon="google" />
      </a>
    </div>
  );
};
