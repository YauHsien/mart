defmodule M.Accounting.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.Accounting.Registry},
      M.Accounting.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Accounting.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
