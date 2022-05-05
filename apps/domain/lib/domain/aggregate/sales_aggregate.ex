defmodule M.Domain.Aggregate.SalesAggregate do
	alias M.Domain.SalesAggregate.Shop
  alias M.Domain.SalesAggregate.SalesOrder
  alias M.Domain.SalesAggregate.Payment


  defdelegate create(shop, sales_order_list \\ []), to: Shop
  defdelegate create_sales_order(id, create_at, sku_list, payment), to: SalesOrder, as: :create
  defdelegate create_pyament(id, create_at, amount), to: Payment, as: :create

  defdelegate get_sales_orders(shop), to: Shop
  defdelegate get_sales_orders(shop, sku), to: Shop

  defdelegate get_paid_sales_orders(shop), to: Shop
  defdelegate get_paid_sales_orders(shop, sku), to: Shop

  defdelegate get_unpaid_sales_orders(shop), to: Shop
  defdelegate get_unpaid_sales_orders(shop, sku), to: Shop

  defdelegate add_sales_order(shop, sales_order), to: Shop
  defdelegate add_sales_order(shop, sales_order, sku_rate_list, payment), to: Shop

end
