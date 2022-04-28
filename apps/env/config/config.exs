# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mart_env,
  namespace: M.Env

# Configures the endpoint
config :mart_env, M.EnvWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: M.EnvWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Env.PubSub,
  live_view: [signing_salt: "FQmpAh0k"]


config :mart_env,
  wait_milliseconds_for_node_connection: 200,
  groups: [:node, :app, :service, :repo],
  nodes: [:'repo@yauhsien-Precision-5540']


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



config :mart_env, :server_security,
  private_key: (quote do: ExPublicKey.load!("priv/server_pem/mart_pem", "321@mart@321"))


config :mart_env, :"mart:env:#{:node}:keys", []

config :mart_env, :"mart:env:#{:app}:keys",
  showwindow: :"mart:env:#{:app}:showwindow",
  backoffice: :"mart:env:#{:app}:backoffice",
  shop: :"mart:env:#{:app}:shop",
  cashier: :"mart:env:#{:app}:cashier",
  checkpoint: :"mart:env:#{:app}:checkpoint",
  studio: :"mart:env:#{:app}:studio"

config :mart_env, :"mart:env:#{:service}:keys", []

config :mart_env, :"mart:env:#{:repo}:keys",
  accounting: :"mart:env:#{:repo}:accounting",
  member: :"mart:env:#{:repo}:member",
  host: :"mart:env:#{:repo}:shop:host",
  sale: :"mart:env:#{:repo}:sale",
  payment: :"mart:env:#{:repo}:payment",
  course: :"mart:env:#{:repo}:course"



config :mart_env, :"mart:env:#{:repo}:member",
  username: "m",
  password: "321@mart@321",
  hostname: "localhost",
  database: "m_member",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
