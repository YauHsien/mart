import Config
alias Phoenix.PubSub

config :sprawl, seed_node: :"seed@yauhsien-Precision-5540"

config :phoenix, :json_library, Poison

config :node_resources, :supervisor,
  child_spec_list: quote do: [
  Supervisor.child_spec({PubSub, name: Node.Repo.CommandChannel}, id: :npub01),
  Supervisor.child_spec({PubSub, name: Node.Repo.QueryChannel}, id: :npub02)
]

config :mart_repo, :node_resources,
  pubsub_repo_query: Node.Repo.QueryChannel,
  pubsub_repo_command: Node.Repo.CommandChannel

config :mart_repo, :subscribing_topics,
  for_member: "PubSub.Member.RequestTopic",
  for_branding: "PubSub.Branding.RequestTopic",
  for_portfolio: "PubSub.Portfolio.RequestTopic",
  for_course: "PubSub.Course.RequestTopic",
  for_listing: "PubSub.Listing.RequestTopic",
  for_sales: "PubSub.Sales.RequestTopic"
