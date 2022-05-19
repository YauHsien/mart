import YDToolkit
alias M.Domain.Branding
alias M.Domain.Listing
alias M.Domain.ByGroup.TutoringBrandRepository
alias TutoringBrandRepository.Protocol

defprotocol Protocol do
	#TODO: need impl.
end

repository TutoringBrandRepository do
  alias Branding.TutoringBrandEntity, as: BrandingTBE
  alias Listing.TutoringBrandEntity, as: ListingTBE
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_tutoring_brand_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
