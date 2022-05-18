defprotocol M.Domain.ByGroup.CourseModel do
  def create(opts)
end

defimpl M.Domain.ByGroup.CourseModel, for: M.Domain.Application.ListingApplication do
  def create(opts), do: M.Domain.Listing.CourseAggregate.create(opts)
end

defimpl M.Domain.ByGroup.CourseModel, for: M.Domain.Application.BrandingApplication do
  def create(opts), do: M.Domain.Branding.CourseAggregate.create(opts)
end

defimpl M.Domain.ByGroup.CourseModel, for: M.Domain.Application.PortfolioApplication do
  def create(opts), do: M.Domain.Portfolio.CourseAggregate.create(opts)
end

defimpl M.Domain.ByGroup.CourseModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.CourseAggregate.create(opts)
end
