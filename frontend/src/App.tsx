import React, { useEffect, useState } from "react";
import { BrowserRouter, Redirect, Route, Switch } from "react-router-dom";
import { useAsync } from "react-use";
import { AppLayout } from "./layouts/AppLayout";
import { ActivityFeed } from "./pages/ActivityFeed";
import { Doors } from "./pages/Doors";
import { Keys } from "./pages/Keys";
import { NotFound } from "./pages/NotFound";
import { AppRoute } from "./utils/routes";
import { API, APIRoute } from "./utils/api";
import { RequireLogin } from "./components/RequireLogin";
import { UserContext } from "./utils/user-context";

export const App: React.FC = () => {
  const userState = useAsync(async () => {
    const { data } = await API.get(APIRoute.Auth);
    return data;
  });

  const [user, setUser] = useState();

  useEffect(() => {
    setUser(userState.value);
  }, [userState.value]);

  if (userState.loading) {
    return null;
  }

  return (
    <UserContext.Provider value={{ user, setUser }}>
      <BrowserRouter>
        <RequireLogin>
          <AppLayout>
            <Switch>
              <Redirect exact from={AppRoute.Root} to={AppRoute.Activity} />
              <Route exact path={AppRoute.Activity}>
                <ActivityFeed />
              </Route>
              <Route exact path={AppRoute.Doors}>
                <Doors />
              </Route>
              <Route exact path={AppRoute.Keys}>
                <Keys />
              </Route>
              <NotFound />
            </Switch>
          </AppLayout>
        </RequireLogin>
      </BrowserRouter>
    </UserContext.Provider>
  );
};
