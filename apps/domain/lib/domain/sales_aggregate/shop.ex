defmodule M.Domain.SalesAggregate.Shop do
  alias M.Domain.ListingsAggregate
	alias M.Domain.SalesAggregate.SalesOrder
  alias M.Domain.SalesAggregate.Payment

  @type id() :: integer() | String.t()



  use TypedStruct

  @doc """
  Object: Shop
  Aggregate: Sales
  """

  typedstruct do
    field :id, id(), enforce: true
    field :create_at, NaiveDateTime.t(), enforce: true
    field :name, String.t(), enforce: true
    field :sales_order_list, List.t(), default: []
  end


  @spec create(ListingsAggregate.Shop.t()) :: t()

  @spec create(ListingsAggregate.Shop.t(), [SalesOrder.t()]) :: t()

  def create(shop, sales_order_list \\ []) do
    %__MODULE__{
      id: shop.id,
      create_at: shop.create_at,
      name: shop.name,
      sales_order_list: sales_order_list
    }
  end



  @spec get_sales_orders(t()) :: [SalesOrder.t()]

  def get_sales_orders(shop) do
    shop.sales_order_list
  end


  @spec get_sales_orders(t(), String.t()) :: [SalesOrder.t()]

  def get_sales_orders(shop, sku) do
    shop.sales_order_list
    |> Enum.filter(&( SalesOrder.get_by(&1,sku) != nil ))
  end



  @spec get_paid_sales_orders(t()) :: [SalesOrder.t()]

  def get_paid_sales_orders(shop),
    do: get_sales_orders(shop)
    |> Enum.filter(&( &1.payment != nil ))


  @spec get_paid_sales_orders(t(), String.t()) :: [SalesOrder.t()]

  def get_paid_sales_orders(shop, sku),
    do: get_sales_orders(shop, sku)
    |> Enum.filter(&( &1.payment != nil ))



  @spec get_unpaid_sales_orders(t()) :: [SalesOrder.t()]

  def get_unpaid_sales_orders(shop),
    do: get_paid_sales_orders(shop)
    |> Enum.filter(&( &1.payment == nil ))


  @spec get_unpaid_sales_orders(t(), String.t()) :: [SalesOrder.t()]

  def get_unpaid_sales_orders(shop, sku),
    do: get_paid_sales_orders(shop, sku)
    |> Enum.filter(&( &1.payment == nil ))



  @spec add_sales_order(t(), SalesOrder.t()) :: t()

  def add_sales_order(shop, sales_order),
    do: %__MODULE__{
          shop |
          sales_order_list: shop.sales_order_list ++ [sales_order]
    }



  @spec add_sales_order(
    t(),
    SalesOrder.t(),
    [{ sku :: String.t(), rate :: float() }],
    Payment.t()
  )
  :: t()

  def add_sales_order(shop, sales_order, sku_rate_list \\ [], payment \\ nil) do
    sku_rate_list
    |> elem(1)
    |> Enum.sum()
    |> then(&(
          %SalesOrder{
            sales_order |
            rate: &1,
            sku_list: sku_rate_list,
            payment: payment
          })
    )
    |> then(&(
          %__MODULE__{
            shop |
            sales_order_list: shop.sales_order_list ++ [&1]
          }
        ))
  end


end
