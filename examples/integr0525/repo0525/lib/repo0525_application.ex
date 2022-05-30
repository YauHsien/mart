defmodule Repo0525.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, args) do
    Supervisor.start_link(args, strategy: :one_for_one, name: Repo0525.Supervisor)
  end
end
