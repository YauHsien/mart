import YDToolkit
alias M.Domain.Branding
alias M.Domain.Course
alias M.Domain.Listing
alias M.Domain.ByGroup.TutorRepository
alias TutorRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository TutorRepository do
  alias Branding.TutorEntity, as: BrandingTE
  alias Course.TutorAggregate
  alias Listing.TutorEntity, as: ListingTE
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_tutor_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
