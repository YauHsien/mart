defprotocol M.Domain.ByApp.PaymentModel do
  def create(opts)
end

defimpl M.Domain.ByApp.PaymentModel, for: M.Domain.Application.SalesApplication do
  def create(opts), do: M.Domain.Sales.PaymentEntity.create(opts)
end
