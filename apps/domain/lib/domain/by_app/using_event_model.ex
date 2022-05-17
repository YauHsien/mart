defprotocol M.Domain.UsingEventModel do
  def create(opts)
end

defimpl M.Domain.UsingEventModel, for: M.Domain.Application.PortfoioApplication do
  def create(opts), do: M.Domain.Portfolio.UsingEventEntity.create(opts)
end
