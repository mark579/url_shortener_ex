import Config

# Configure Database
config :url_shortener_ex, UrlShortenerEx.Repo,
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASS"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :url_shortener_ex, UrlShortenerExWeb.Endpoint, http: [ip: {127, 0, 0, 1}, port: 4000]
# Do not print debug messages in production
config :logger, level: :info
