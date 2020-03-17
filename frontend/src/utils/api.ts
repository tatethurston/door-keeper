import axios from "axios";
import qs from "qs";

axios.defaults.xsrfHeaderName = "X-CSRF-TOKEN";
axios.defaults.xsrfCookieName = "CSRF-TOKEN";
axios.defaults.headers["Accept"] = "application/json";
axios.defaults.headers["Content-Type"] = "application/json";

// https://stackoverflow.com/questions/47843407/how-to-send-json-data-correctly-using-axios-to-a-rails-server-to-match-the-requ
axios.defaults.paramsSerializer = params =>
  qs.stringify(params, { arrayFormat: "brackets" });

export const API = axios;

export const APIRoute = {
  Auth: "/users/auth",
  Login: "/users/auth/google_oauth2",
  Logout: "/users/auth/sign_out"
};
