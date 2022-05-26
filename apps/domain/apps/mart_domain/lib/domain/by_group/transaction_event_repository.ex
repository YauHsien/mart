import YDToolkit
alias M.Domain.Sales
alias M.Domain.ByGroup.TransactionEventRepository
alias TransactionEventRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository TransactionEventRepository do
  alias Sales.TransactionEventEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_transaction_event_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
