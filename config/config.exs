# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :food,
  ecto_repos: [Food.Repo]

# Configures the endpoint
config :food, FoodWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pc1//spwbYR5EkCHOTMx+eQExeFE9tg8yKkY2w7FPNm6AmyB+Lm6m0JilI4MUB9R",
  render_errors: [view: FoodWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Food.PubSub,
  live_view: [signing_salt: "2lFHD3Bp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
