# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mart,
  namespace: M.Lobby,
  node_env: :"env@yauhsien-Precision-5540"

# Configures the endpoint
config :mart, M.LobbyWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: M.LobbyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lobby.PubSub,
  live_view: [signing_salt: "nP6YK9LO"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :mart, M.Lobby.Mailer, adapter: Swoosh.Adapters.Local

config :mart, :server_security,
  public_key: (quote do: ExPublicKey.load!("priv/server_pem/mart_pem.pub", "321@mart@321")),
  private_key: (quote do: ExPublicKey.load!("priv/server_pem/mart_pem", "321@mart@321"))

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sprawl, seed_node: :"env@yauhsien-Precision-5540"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
