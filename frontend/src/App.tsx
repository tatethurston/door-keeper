import React from "react";
import { BrowserRouter, Switch, Redirect, Route } from "react-router-dom";
import { AppLayout } from "./layouts/AppLayout";
import { ActivityFeed } from "./pages/ActivityFeed";
import { Keys } from "./pages/Keys";
import { Doors } from "./pages/Doors";
import { NotFound } from "./pages/NotFound";
import { AppURL } from "./utils/routes";

export const App: React.FC = () => {
  return (
    <BrowserRouter>
      <AppLayout>
        <Switch>
          <Redirect exact from={AppURL.Root} to={AppURL.Activity} />
          <Route exact path={AppURL.Activity}>
            <ActivityFeed />
          </Route>
          <Route exact path={AppURL.Doors}>
            <Doors />
          </Route>
          <Route exact path={AppURL.Keys}>
            <Keys />
          </Route>
          <NotFound />
        </Switch>
      </AppLayout>
    </BrowserRouter>
  );
};
