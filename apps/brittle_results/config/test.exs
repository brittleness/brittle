use Mix.Config

config :brittle_results, Brittle.Repo,
  adapter: Sqlite.Ecto2,
  database: "brittle.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox

config :brittle_results,
  ecto_repos: [Brittle.Repo],
  system: SystemMock
