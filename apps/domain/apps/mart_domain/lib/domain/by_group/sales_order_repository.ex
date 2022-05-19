import YDToolkit
alias M.Domain.Sales
alias M.Domain.ByGroup.SalesOrderRepository
alias SalesOrderRepository.Protocol

defprotocol Protocol do
  #TODO: need impl.
end

repository SalesOrderRepository do
  alias Sales.SalesOrderAggregate
  @command_channel Application.fetch_env!(:mart_domain, :repo_write_pub_sub)
  @query_channel Application.fetch_env!(:mart_domain, :repo_read_pub_sub)
  @repository Application.fetch_env!(:mart_domain, :repo_for_sales_order_model)

  use TypedStruct
  typedstruct do
    field :id, :atom, default: @repository
  end

  defimpl Protocol do
    #TODO: need impl.
  end
end
