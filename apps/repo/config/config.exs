# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configure your database
config :mart_repo, M.Repo.ReadOnlyRepo,
  username: "m",
  password: "321@mart@321",
  hostname: "localhost",
  database: "m_member",
  show_sensitive_data_on_connection_error: true,
  pool_size: 5

config :mart_repo, M.Repo.Repo,
  username: "m",
  password: "123@mart@321",
  hostname: "localhost",
  database: "m_member",
  pool_size: 10

config :mart_repo,
  namespace: M.Repo,
  ecto_repos: [M.Repo.Repo],
  node_env: :"env@yauhsien-Precision-5540"

# Configures the endpoint
config :mart_repo, M.RepoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: M.RepoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Repo.PubSub,
  live_view: [signing_salt: "B4M8BVic"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sprawl, seed_node: :"env@yauhsien-Precision-5540"

config :mart_repo, :node_resources,
  pubsub_repo_query: Node.Repo.Query.PubSub,
  pubsub_repo_command: Node.Repo.Command.PubSub,
  pubsub_env: Node.Env.PubSub

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
