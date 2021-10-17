const { createProxyMiddleware } = require("http-proxy-middleware");

module.exports = function (app) {
  app.use(
    ["/api", "/[a-zA-Z0-9]{15,}$"],
    createProxyMiddleware({
      target: "http://localhost:4000",
      changeOrigin: true,
      pathRewrite: function (path, req) {
        const has_api = hasApi(path);
        if (!has_api) {
          path = "/api/urls" + path;
        }
        return path;
      },
    })
  );
};

function hasApi(path) {
  if (path.indexOf("/api/") !== -1) {
    return true;
  }
  return false;
}
