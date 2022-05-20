defmodule M.Domain.Application.SalesApplication do
  use Application

  def start(_start_type, _start_args) do
    Supervisor.start_link(children(), strategy: :one_for_one, name: __MODULE__.Supervisor)
  end

  defp children() do
    []
  end
end
