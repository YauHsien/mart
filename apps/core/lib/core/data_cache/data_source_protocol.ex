defprotocol M.Core.DataCache.DataSourceProtocol do
  @spec query(
    {:via, Registry, {:atom, Registry.key()}} | term(),
    struct()
  ):: term()
  def query(server, access_message)
end
