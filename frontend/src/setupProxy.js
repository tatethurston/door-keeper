const { createProxyMiddleware } = require("http-proxy-middleware");

module.exports = function(app) {
  app.use(
    createProxyMiddleware("/users/auth", {
      target: "http://localhost:5000"
    })
  );
};
