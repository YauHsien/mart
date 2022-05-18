defprotocol M.Domain.ByApp.PricingEventModel do
  def create(opts)
end

defimpl M.Domain.ByApp.PricingEventModel, for: M.Domain.Application.ListingApplication do
  def create(opts), do: M.Domain.Listing.PricingEventEntity.create(opts)
end
