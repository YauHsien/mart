defprotocol M.Domain.ByApp.TransactionEventModel do
  def create(opts)
end

defimpl M.Domain.ByApp.TransactionEventModel, for: M.Domain.Application.SalesApplication do
  def create(opts), do: M.Domain.Sales.TransactionEventEntity.create(opts)
end
