defprotocol M.Domain.ByApp.SalesOrderModel do
  def create(opts)
end

defimpl M.Domain.ByApp.SalesOrderModel, for: M.Domain.Application.SalesApplication do
  def create(opts), do: M.Domain.Sales.SalesOrderAggregate.create(opts)
end
