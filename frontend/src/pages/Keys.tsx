import React from "react";
import { Header, Icon, Item } from "semantic-ui-react";
import { Page } from "src/layouts/Page";
import { APIRoute } from "src/utils/api";
import { useAPI } from "src/utils/useAPI";
import { Loading } from 'src/components/Loading';

export const Keys: React.FC = () => {
  const codes = useAPI<any>(APIRoute.Codes);
  const loading = !codes.value;

  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="key" />
          <Header.Content>Keys</Header.Content>
        </Header>
      }
    >
      { loading ?
        <Loading /> :
        <Item.Group>
          { codes.value.map((code: any) =>
            <Item key={code.id}>
              <Item.Content>
                <Item.Header>{code.name}</Item.Header>
                <Item.Meta>{code.allowed_time}</Item.Meta>
                <Item.Description>
                  Code: { code.value}
                </Item.Description>
              </Item.Content>
            </Item>
          )}
        </Item.Group>
      }
    </Page>
  );
};
