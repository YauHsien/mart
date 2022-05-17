defprotocol M.Domain.TutoringBrandModel do
  def create(opts)
end

defimpl M.Domain.TutoringBrandModel, for: M.Domain.Application.ListingApplication do
  def create(opts), do: M.Domain.Listing.TutoringBrandEntity.create(opts)
end

defimpl M.Domain.TutoringBrandModel, for: M.Domain.Application.BrandingApplication do
  def create(opts), do: M.Domain.Branding.TutoringBrandEntity.create(opts)
end
