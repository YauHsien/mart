import YDToolkit
alias M.Domain.Branding
alias M.Domain.ByGroup.HandlingEventRepository
alias Portfolio.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository HandlingEventRepository do
  alias Branding.HandlingEventEntity
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_handling_event_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
