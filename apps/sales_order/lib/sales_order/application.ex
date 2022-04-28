defmodule M.SalesOrder.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.SalesOrder.Registry},
      M.SalesOrder.Worker
    ]

    opts = [strategy: :one_for_one, name: M.SalesOrder.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
