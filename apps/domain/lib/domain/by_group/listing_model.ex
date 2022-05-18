defprotocol M.Domain.ByApp.ListingModel do
  def create(opts)
end

defimpl M.Domain.ByApp.ListingModel, for: M.Domain.Application.SalesApplication do
  def create(opts), do: M.Domain.Sales.ListingEntity.create(opts)
end

defimpl M.Domain.ByApp.ListingModel, for: M.Domain.Application.ListingApplication do
  def create(opts), do: M.Domain.Listings.ListingAggregate.create(opts)
end
