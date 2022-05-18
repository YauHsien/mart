import YDToolkit

repository M.Domain.TutorRepository do
  alias M.Domain.Branding.TutorEntity, as: BrandingTutorEntity
  alias M.Domain.Course.TutorAggregate
  alias M.Domain.Listing.TutorEntity, as: ListingTutorEntity
  @repository Application.fetch_env!(:mart_domain, :repo_for_tutor_model)

  def create(%BrandingTutorEntity{} = entity) do
    entity
  end

end
