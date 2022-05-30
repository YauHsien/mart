# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

#TODO: remove dependencies
config :mart_domain,
  repo_for_bought_package_model: Domain.BoughtPackageModel.Repository,
  repo_for_course_model: Domain.CourseModel.Repository,
  repo_for_customer_model: Domain.CustomerModel.Repository,
  repo_for_handling_event_model: Domain.HandingEventModel.Repository,
  repo_for_lecturing_specification_model: Domain.LecturingSpecificationModel.Repository,
  repo_for_listing_model: Domain.ListingModel.Repository,
  repo_for_payment_model: Domain.PaymentModel.Repository,
  repo_for_pricing_event_model: Domain.PricingEventModel.Repository,
  repo_for_room_model: Domain.RoomModel.Repository,
  repo_for_sales_order_model: Domain.SalesOrderModel.Repository,
  repo_for_transaction_event_model: Domain.TransactionEventModel.Repository,
  repo_for_tutor_model: Domain.TutorModel.Repository,
  repo_for_tutoring_brand_model: Domain.TutoringBrand.Repository,
  repo_for_using_event_model: Domain.UsingEventModel.Repository

# Configure your database
config :mart_repo, M.Repo.ReadOnlyRepository,
  username: "m",
  password: "321@mart@321",
  hostname: "localhost",
  database: "m_member",
  show_sensitive_data_on_connection_error: true,
  pool_size: 5

config :mart_repo, M.Repo.ReadWriteRepository,
  username: "m",
  password: "123@mart@321",
  hostname: "localhost",
  database: "m_member",
  show_sensitive_data_on_connection_error: false,
  pool_size: 10

config :mart_repo,
  namespace: M.Repo,
  ecto_repos: [M.Repo.ReadWriteRepository],
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

config :mart_domain, :node_resources,
  pubsub_repo_query: Node.Repo.QueryChannel,
  pubsub_repo_command: Node.Repo.CommandChannel,
  pubsub_domain: Node.Domain.Channel,
  pubsub_lobby: Node.Lobby.Channel

config :mart_repo, :subscribing_topics,
  for_member: PubSub.Member.RequestTopic,
  for_branding: PubSub.Branding.RequestTopic,
  for_portfolio: PubSub.Portfolio.RequestTopic,
  for_course: PubSub.Course.RequestTopic,
  for_listing: PubSub.Listing.RequestTopic,
  for_sales: PubSub.Sales.RequestTopic

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
