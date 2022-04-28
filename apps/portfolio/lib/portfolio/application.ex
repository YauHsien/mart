defmodule M.Portfolio.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.Portfolio.Registry},
      M.Portfolio.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Portfolio.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
