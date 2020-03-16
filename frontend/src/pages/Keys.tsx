import React from "react";
import { Header, Icon } from "semantic-ui-react";
import { Page } from "src/layouts/Page";

export const Keys: React.FC = () => {
  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="key" />
          <Header.Content>Keys</Header.Content>
        </Header>
      }
    >
      <p>Keys</p>
    </Page>
  );
};
