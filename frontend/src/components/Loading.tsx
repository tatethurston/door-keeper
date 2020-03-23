import React, { useEffect, useState } from "react";
import { Loader } from "semantic-ui-react";

export const Loading: React.FC = () => {
  const [show, setShow] = useState(false);

  const waitMs = 1000;
  useEffect(() => {
    const id = setTimeout(() => {
      setShow(true);
    }, waitMs)
    return () => clearTimeout(id);
  }, [])

  if (!show) {
    return null
  }

  return <Loader active />
}
