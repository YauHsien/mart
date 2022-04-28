defmodule M.Classroom.Application do
  @moduledoc false

  use Application


  @impl true
  def start(_type, _args) do

    children = [
      {Registry, keys: :unique, name: M.Classroom.Registry},
      M.Classroom.Worker
    ]

    opts = [strategy: :one_for_one, name: M.Classroom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
