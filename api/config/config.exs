# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dora,
  ecto_repos: [Dora.Repo]

# Configures the endpoint
config :dora, Dora.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JARjQvuD2ODpuvkLKgXxrPhS8dVl+khee8l5gy04O8JbfkiVePGPbdcE5ACDhbOY",
  render_errors: [view: Dora.ErrorView, accepts: ~w(json)],
  pubsub: [name: Dora.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Dora",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Dora.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
