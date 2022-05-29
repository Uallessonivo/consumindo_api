# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :consumindo_api,
  ecto_repos: [ConsumindoApi.Repo]

config :consumindo_api, ConsumindoApi.Repos.Get,
  get_repositories_adapter: ConsumindoApi.Github.Client

config :consumindo_api, ConsumindoApi.Repo, migration_primary_key: [type: :binary_id]

config :consumindo_api, ConsumindoApiWeb.Auth.Guardian,
  issuer: "consumindo_api",
  secret_key: "z4HuMYeHs4gdrdVVYiTt8ceFgPFyMq831GtoI4+91Tb+7aOaw4enuANOxXTD2i"

config :consumindo_api, ConsumindoApiWeb.Auth.Pipeline,
  module: ConsumindoApiWeb.Auth.Guardian,
  error_handler: ConsumindoApiWeb.Auth.ErrorHandler

# Configures the endpoint
config :consumindo_api, ConsumindoApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ConsumindoApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ConsumindoApi.PubSub,
  live_view: [signing_salt: "ixwZX5xv"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :consumindo_api, ConsumindoApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
