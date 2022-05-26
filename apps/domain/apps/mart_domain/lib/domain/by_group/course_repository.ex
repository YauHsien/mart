import YDToolkit
alias M.Domain.Branding
alias M.Domain.Course
alias M.Domain.Listing
alias M.Domain.Portfoio
alias M.Domain.ByGroup.CourseRepository
alias CourseRepository.Protocol

defprotocol Protocol do
	#TODO: need impl.
end

repository CourseRepository do
  alias Branding.CourseAggregate, as: BrandingCA
  alias Course.CourseAggregate, as: CourseCA
  alias Listing.CourseAggregate, as: ListingCA
  alias Portfolio.CourseAggregate, as: PortfolioCA
  @command_channel M.Domain.pubsub_repo_command()
  @query_channel M.Domain.pubsub_repo_query()
  @repository Application.fetch_env!(:mart_domain, :repo_for_bought_package_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
