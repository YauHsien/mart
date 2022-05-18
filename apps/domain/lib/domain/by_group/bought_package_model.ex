defprotocol M.Domain.ByGroup.BoughtPackageModel do
  def create(opts)
end

defimpl M.Domain.BoughtPackageModel, for: M.Domain.Application.PortfolioApplication do
  def create(opts), do: M.Domain.Portfolio.BoughtPackageAggregate.create(opts)
end

defimpl M.Domain.BoughtPackageModel, for: M.Domain.Application.CourseApplication do
  def create(opts), do: M.Domain.Course.BoughtPackageEntity.create(opts)
end
