defmodule M.Shop.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.Shop.Registry},
      M.Shop.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Shop.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
