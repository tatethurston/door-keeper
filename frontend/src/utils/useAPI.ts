import { useContext } from "react";
import { UserContext } from "src/utils/user-context";
import { API, APIPath } from "src/utils/api";
import { useAsync } from "react-use";
import { AsyncState } from "react-use/lib/useAsync";

export const useAPI = <T>(path: APIPath): AsyncState<T> => {
  const { setUser } = useContext(UserContext);

  const response = useAsync(async () => {
    try {
      const { data } = await API.get(path);
      return data;
    } catch(error) {
      if (error.response.status === 401) {
        setUser(undefined)
      }
      throw error;
    }
  });

  return response;
}
