import YDToolkit
alias M.Domain.Course
alias M.Domain.Sales
alias M.Domain.ByGroup.ListingRepository
alias ListingRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository ListingRepository do
  alias Course.CustomerAggregate
  alias Sales.CustomerEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_listing_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
