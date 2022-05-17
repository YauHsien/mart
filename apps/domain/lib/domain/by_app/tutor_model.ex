defprotocol M.Domain.ByApp.TutorModel do
  def create(opts)
end

defimpl M.Domain.ByApp.TutorModel, for: M.Domain.Application.ListingApplication do
  def create(opts), do: M.Domain.Listing.TutorEntity.create(opts)
end

defimpl M.Domain.ByApp.TutorModel, for: M.Domain.Application.BrandingApplication do
  def create(opts), do: M.Domain.Branding.TutorEntity.create(opts)
end

defimpl M.Domain.ByApp.TutorModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.TutorAggregate.create(opts)
end
