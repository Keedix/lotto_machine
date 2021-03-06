# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lotto_machine,
  ecto_repos: [LottoMachine.Repo],
  bcrypt: LottoMachine.Bcrypt,
  salt: "$2b$12$jyA5aAwdfJN3CLyKAb.dje",
  generators: [
    {:lotto, LottoMachine.Generator.Lotto},
    {:multi_multi, LottoMachine.Generator.MultiMulti}
  ]

# Configures the endpoint
config :lotto_machine, LottoMachineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "djUGg788sUEH0VuRBbsk69vSIqmoXARvdksV/Hhx/yNl5iF+D34DuQBQeJU0lija",
  render_errors: [view: LottoMachineWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LottoMachine.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
