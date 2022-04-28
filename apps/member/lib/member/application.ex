defmodule M.Member.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.Member.Registry},
      M.Member.Worker,
      M.Member.AggregateEmitter
    ]

    opts = [strategy: :one_for_one, name: M.Member.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
