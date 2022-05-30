import YDToolkit
alias M.Domain.Portfolio
alias M.Domain.ByGroup.UsingEventRepository
alias Portfolio.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository UsingEventRepository do
  alias Portfolio.UsingEventEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_using_event_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
