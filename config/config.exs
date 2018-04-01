use Mix.Config

config :brittle_results, Brittle.Repo,
  adapter: Sqlite.Ecto2,
  database: "brittle.sqlite3"

config :brittle_results, ecto_repos: [Brittle.Repo]
