import React from "react";
import { Header, Icon, Item } from "semantic-ui-react";
import { Page } from "src/layouts/Page";
import { APIRoute } from "src/utils/api";
import { useAPI } from "src/utils/useAPI";
import { Loading } from 'src/components/Loading';

export const Doors: React.FC = () => {
  const doors = useAPI<any>(APIRoute.Doors);
  const loading = !doors.value;

  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="building" />
          <Header.Content>Doors</Header.Content>
        </Header>
      }
    >
      { loading ?
        <Loading /> :
        <Item.Group>
          { doors.value.map((door: any) =>
            <Item key={door.id}>
              <Item.Content>
                <Item.Header>{door.name}</Item.Header>
                <Item.Meta>{door.timezone}</Item.Meta>
                <Item.Description>
                  Phone: { door.phone_number}
                </Item.Description>
              </Item.Content>
            </Item>
          )}
        </Item.Group>
      }
    </Page>
  );
};
