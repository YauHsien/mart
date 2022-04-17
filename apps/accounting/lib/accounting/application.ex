defmodule M.Accounting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Supervisor.child_spec({Phoenix.PubSub, name: M.Accounting.pub_sub()}, id: :pub_0),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Backoffice.pub_sub()}, id: :pub_1),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Env.pub_sub()}, id: :pub_2),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Finance.pub_sub()}, id: :pub_3),
      Supervisor.child_spec({Phoenix.PubSub, name: M.Repo.pub_sub()}, id: :pub_4),
      # Starts a worker by calling: M.Accounting.Worker.start_link(arg)
      M.Accounting.Worker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: M.Accounting.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
