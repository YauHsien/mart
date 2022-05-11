defmodule M.Domain.Sales.SalesOrderAggregate.SalesOrder do
  use M.Domain.Stereotype, :aggregate_root

  alias M.Domain.Sales.Payment
  alias M.Domain.Sales.SalesOrderAggregate.BuyingItem
  alias M.Domain.Sales.SalesOrderAggregate.SalesOrderHistory

  use TypedStruct
  typedstruct do
    
  end
end
