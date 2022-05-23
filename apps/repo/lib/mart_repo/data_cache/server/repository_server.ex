defmodule M.Repo.DataCache.Server.RepositoryServer do
	import Ecto.Query
  alias M.Core.DataCache.AccessMessage
  alias M.Core.DataCache.DataSourceProtocol
  alias M.Repo.DataCache.Server.RepositoryServer
  alias M.Repo.ReadOnlyRepo

  @type server :: {:via, Registry, {:atom, Registry.key}}

  use TypedStruct
  typedstruct do
    field :name, server(), enforce: true
    field :server, term(), enforce: true
  end

  @spec instance(server()) :: t()
  def instance({:via, Registry, {registry, key}} = name) do
    %__MODULE__{
      name: name,
      server: quote(do: Registry.lookup(registry, key) |> List.first() |> then(& if (&1 == nil), do: nil, else: elem(&1, 1) ))
    }
  end

  defimpl DataSourceProtocol do
    @spec query(RepositoryServer.t(), AccessMessage):: term()
    def query(%RepositoryServer{server: server}, %AccessMessage{message: access_message}),
      do: RepositoryServer.query(server, access_message)
  end

  @spec query(pid(), term()) :: term()
  def query(server, access_message)

  def query(_server, access_message), do: access_message

end
