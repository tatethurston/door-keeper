import React, { useState, useRef } from "react";
import "./AppLayout.css";
import { Nav } from "src/components/Nav";
import { SideNav } from "src/components/SideNav";
import { Sidebar, Ref } from "semantic-ui-react";

export const AppLayout: React.FC = ({ children }) => {
  const [visible, setVisible] = useState(false);
  const contentRef = useRef();

  return (
    <Sidebar.Pushable>
      <SideNav
        visible={visible}
        onHide={() => setVisible(false)}
        target={contentRef}
        onClick={() => setVisible(false)}
      />
      <Ref innerRef={contentRef}>
        <Sidebar.Pusher dimmed={visible}>
          <Nav onClick={() => setVisible(true)} />
          {children}
        </Sidebar.Pusher>
      </Ref>
    </Sidebar.Pushable>
  );
};
