use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :brittle_web, Brittle.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :brittle_results, Brittle.Repo,
  adapter: Sqlite.Ecto2,
  database: "brittle.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox
