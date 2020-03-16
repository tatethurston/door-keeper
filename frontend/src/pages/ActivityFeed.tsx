import React from "react";
import { Header, Icon } from "semantic-ui-react";
import { Page } from "src/layouts/Page";

export const ActivityFeed: React.FC = () => {
  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="clipboard list" />
          <Header.Content>Access Log</Header.Content>
        </Header>
      }
    >
      <p>Acess Log</p>
    </Page>
  );
};
