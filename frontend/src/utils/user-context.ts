import React from "react";

export const UserContext = React.createContext({
  user: undefined,
  setUser: (x: any) => {
    console.log(`[UserContext] Noop received ${x}`);
  }
});
