alias M.Domain.ByApp.TutorModel
alias M.Domain.Branding.TutorEntity, as: BrandingTutorEntity
alias M.Domain.Course.TutorAggregate
alias M.Domain.Listing.TutorEntity, as: ListingTutorEntity
alias M.Domain.TutorRepository

defprotocol TutorModel do
  def create(opts) # TODO: 須刪除 create/1 因為在 Branding Tutor model 不會有新增
end

defimpl TutorModel, for: BrandingTutorEntity do
  def create(%BrandingTutorEntity{} = entity), do: TutorRepository.create(entity)
end
