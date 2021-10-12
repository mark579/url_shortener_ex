import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :url_shortener_ex, UrlShortenerEx.Repo,
  username: "postgres",
  password: "postgres",
  database: "url_shortener_ex_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :url_shortener_ex, UrlShortenerExWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "z7JpRO8uBsyuWi0OEFF83PW86BpZD6RUHl2b5PtmLYfstYVfwbPOKycy5jDjFb8C",
  server: false

# In test we don't send emails.
config :url_shortener_ex, UrlShortenerEx.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
