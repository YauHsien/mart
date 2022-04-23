defmodule M.Classroom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require M.Core.Common
  alias M.Core.Common
  alias M.Core.Node


  @impl true
  def start(_type, _args) do

    Node.connect_node([Application.fetch_env!(:mart_classroom, :node_env)])

    children = [
      Supervisor.child_spec({Phoenix.PubSub, name: Common.classroom_pub_sub_name()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.env_pub_sub_name()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.repo_pub_sub_name()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: Common.studio_pub_sub_name()}, id: :pub_3),
      # Starts a worker by calling: M.Classroom.Worker.start_link(arg)
      M.Classroom.Worker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Classroom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
