import YDToolkit
alias M.Domain.Sales
alias M.Domain.ByGroup.PaymentRepository
alias PaymentRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository PaymentRepository do
  alias Sales.PaymentEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_payment_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
