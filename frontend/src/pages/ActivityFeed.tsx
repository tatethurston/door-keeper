import React from "react";
import { Header, Icon, Feed } from "semantic-ui-react";
import formatRelative from 'date-fns/formatRelative';
import parseISO from 'date-fns/parseISO';
import { Page } from "src/layouts/Page";
import { APIRoute } from "src/utils/api";
import { useAPI } from "src/utils/useAPI";
import { Loading } from 'src/components/Loading';

export const ActivityFeed: React.FC = () => {
  const activity = useAPI<any>(APIRoute.AccessLogs);
  const loading = !activity.value;
  const now = new Date();

  return (
    <Page
      header={
        <Header as="h2">
          <Icon name="clipboard list" />
          <Header.Content>Access Log</Header.Content>
        </Header>
      }
    >
      { loading ?
        <Loading /> :
        <Feed>
          { activity.value.map((event: any) =>
            <Feed.Event key={event.id}>
              <Feed.Content>
                <Feed.Summary>
                  <Feed.User>{event.code?.name || 'Unknown Code'}</Feed.User> { event.success ? 'opened' : 'was denied for' } <Feed.User>{event.door.name}</Feed.User>
                  <Feed.Date>{formatRelative(parseISO(event.created_at), now)}</Feed.Date>
                </Feed.Summary>
                  { event.denied_reason &&
                    <Feed.Meta>
                      Error: { event.denied_reason }
                    </Feed.Meta>
                  }
              </Feed.Content>
            </Feed.Event>
          )}
        </Feed>
      }
    </Page>
  );
};
