defmodule M.Shop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Core.Common
  alias M.Core.Common

  @impl true
  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Phoenix.PubSub, name: Common.shop_pub_sub_name()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.backoffice_pub_sub_name()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.env_pub_sub_name()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.lobby_pub_sub_name()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_pub_sub_name()}, id: :pub_4),
      # Starts a worker by calling: M.Shop.Worker.start_link(arg)
      M.Shop.Worker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Shop.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
