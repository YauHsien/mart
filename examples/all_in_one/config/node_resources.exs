import Config

p_acc = Node.Accounting.PubSub
p_bko = Node.Backoffice.PubSub
p_clm = Node.Classroom.PubSub
p_env = Node.Env.PubSub
p_fnc = Node.Finance.PubSub
p_lby = Node.Lobby.PubSub
p_mbr = Node.Member.PubSub
p_pfo = Node.Portfolio.PubSub
p_rp1 = Node.Repo.Query.PubSub
p_rp2 = Node.Repo.Command.PubSub
p_sod = Node.SalesOrder.PubSub
p_shp = Node.Shop.PubSub
p_std = Node.Studio.PubSub

config :node_resources, :supervisor,
  child_spec_list: quote do: [
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_acc)}, id: :npub_0),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_bko)}, id: :npub_1),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_clm)}, id: :npub_2),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_env)}, id: :npub_3),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_fnc)}, id: :npub_4),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_lby)}, id: :npub_5),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_mbr)}, id: :npub_6),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_pfo)}, id: :npub_7),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_rp1)}, id: :npub_8),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_rp2)}, id: :npub_9),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_sod)}, id: :npub_10),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_shp)}, id: :npub_11),
  Supervisor.child_spec({Phoenix.PubSub, name: unquote(p_std)}, id: :npub_12)
]

config :mart_accounting, :node_resources,
  pubsub_accounting: p_acc,
  pubsub_backoffice: p_bko,
  pubsub_env: p_env,
  pubsub_finance: p_fnc,
  pubsub_lobby: p_lby,
  pubsub_repo_query: p_rp1,
  pubsub_repo_command: p_rp2

config :mart_backoffice, :node_resources,
    pubsub_backoffice: p_bko,
    pubsub_accounting: p_acc,
    pubsub_env: p_env,
    pubsub_member: p_mbr,
    pubsub_portfolio: p_pfo,
    pubsub_sales_order: p_sod,
    pubsub_shop: p_shp

config :mart_classroom, :node_resources,
    pubsub_classroom: p_clm,
    pubsub_env: p_env,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2,
    pubsub_studio: p_std

config :mart_env, :node_resources,
    pubsub_env: p_env,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2

config :mart_finance, :node_resources,
    pubsub_finance: p_fnc,
    pubsub_accounting: p_acc,
    pubsub_env: p_env,
    pubsub_member: p_mbr,
    pubsub_sales_order: p_sod

config :mart, :node_resources,
    pubsub_lobby: p_lby,
    pubsub_accounting: p_acc,
    pubsub_env: p_env,
    pubsub_member: p_mbr,
    pubsub_portfolio: p_pfo,
    pubsub_sales_order: p_sod,
    pubsub_shop: p_shp

config :mart_member, :node_resources,
    pubsub_member: p_mbr,
    pubsub_backoffice: p_bko,
    pubsub_env: p_env,
    pubsub_finance: p_fnc,
    pubsub_lobby: p_lby,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2,
    pubsub_studio: p_std

config :mart_portfolio, :node_resources,
    pubsub_portfolio: p_pfo,
    pubsub_backoffice: p_bko,
    pubsub_env: p_env,
    pubsub_lobby: p_lby,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2,
    pubsub_studio: p_std

config :mart_repo, :node_resources,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2,
    pubsub_env: p_env

config :mart_sales_order, :node_resources,
    pubsub_sales_order: p_sod,
    pubsub_backoffice: p_bko,
    pubsub_env: p_env,
    pubsub_finance: p_fnc,
    pubsub_lobby: p_lby,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2

config :mart_shop, :node_resources,
    pubsub_shop: p_shp,
    pubsub_backoffice: p_bko,
    pubsub_env: p_env,
    pubsub_lobby: p_lby,
    pubsub_repo_query: p_rp1,
    pubsub_repo_command: p_rp2

config :mart_studio, :node_resources,
    pubsub_studio: p_std,
    pubsub_classroom: p_clm,
    pubsub_env: p_env,
    pubsub_member: p_mbr,
    pubsub_portfolio: p_pfo
