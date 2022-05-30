import YDToolkit
alias M.Domain.Branding
alias M.Domain.ByGroup.HandlingEventRepository
alias Portfolio.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository HandlingEventRepository do
  alias Branding.HandlingEventEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_handling_event_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
