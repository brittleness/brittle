use Mix.Config

config :brittle_results,
  ecto_repos: [Brittle.Repo]

import_config "#{Mix.env}.exs"
