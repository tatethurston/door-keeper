import React from "react";
import { Header, Icon } from "semantic-ui-react";
import { Page } from "src/layouts/Page";

export const NotFound: React.FC = () => {
  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="warning sign" />
          <Header.Content>Not Found</Header.Content>
        </Header>
      }
    >
      <p>Sorry, we couldn't find that.</p>
    </Page>
  );
};
