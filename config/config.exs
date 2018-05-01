# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :brittle_web, Brittle.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1MAFVuhrdll2rcYWilTsD5GJ1yRkCMByUw4QMOo61ht7B/Yk6Xe7gildg0SAo/Zt",
  render_errors: [view: Brittle.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Brittle.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :brittle_web, ecto_repos: [Brittle.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
