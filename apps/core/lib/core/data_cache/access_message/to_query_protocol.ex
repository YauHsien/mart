alias M.Core.DataCache
alias DataCache.AccessMessage
alias DataCache.BrandingAccessMessage
alias DataCache.CourseAccessMessage
alias DataCache.ListingAccessMessage
alias DataCache.PortfolioAccessMessage
alias DataCache.SalesAccessMessage
alias AccessMessage.ToQueryProtocol

defprotocol AccessMessage.ToQueryProtocol do
  @spec access_by(struct()) :: Ecto.Query.t()
  def access_by(acccess_message)
end

defimpl AccessMessage.ToQueryProtocol, for: BrandingAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: CourseAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: ListingAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: PortfolioAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
defimpl AccessMessage.ToQueryProtocol, for: SalesAccessMessage do
  def access_by(access_message) do
    raise "not implemented for #{inspect access_message}"
  end
end
