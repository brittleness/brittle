use Mix.Config

config :brittle_results, Brittle.Repo,
  adapter: Sqlite.Ecto2,
  database: "brittle.sqlite3",
  pool: Ecto.Adapters.SQL.Sandbox

config :brittle_importer,
  ecto_repos: [Brittle.Repo]

config :brittle_importer,
  payload_directory: "_build/test/payloads/#{Enum.random(100..999)}"
