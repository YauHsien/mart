defprotocol M.Domain.ByGroup.CustomerModel do
	def create(opts)
end

defimpl M.Domain.ByGroup.CustomerModel, for: M.Domain.Application.SalesApplication do
  def create(opts), do: M.Domain.Sales.CustomerEntity.create(opts)
end

defimpl M.Domain.ByGroup.CustomerModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.CustomerAggregate.create(opts)
end
