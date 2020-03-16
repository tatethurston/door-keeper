import React from "react";
import "./Page.css";
import { Segment, Container } from "semantic-ui-react";

interface PageProps {
  header: JSX.Element;
}

export const Page: React.FC<PageProps> = ({ header, children }) => {
  return (
    <Container className="page">
      {header}
      <Segment basic>{children}</Segment>
    </Container>
  );
};
