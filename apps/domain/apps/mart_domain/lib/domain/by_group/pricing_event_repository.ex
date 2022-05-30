import YDToolkit
alias M.Domain.Listing
alias M.Domain.ByGroup.PricingEventRepository
alias PricingEventRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository PricingEventRepository do
  alias Listing.PricingEventEntity
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_pricing_event_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
