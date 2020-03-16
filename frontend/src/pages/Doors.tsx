import React from "react";
import { Header, Icon } from "semantic-ui-react";
import { Page } from "src/layouts/Page";

export const Doors: React.FC = () => {
  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="building" />
          <Header.Content>Doors</Header.Content>
        </Header>
      }
    >
      <p>Keys</p>
    </Page>
  );
};
