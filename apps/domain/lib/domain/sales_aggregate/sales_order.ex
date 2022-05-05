defmodule M.Domain.SalesAggregate.SalesOrder do
	alias M.Domain.SalesAggregate.Payment

  @type id() :: integer() | String.t()



  use TypedStruct

  @doc """
  Object: Sales order
  Aggregate: Sales
  """

  typedstruct do
    field :id, id(), enforce: true
    field :create_at, NaiveDateTime.t(), enforce: true
    field :rate, float(), enforce: true
    field :sku_list, [{ sku :: String.t(), rate :: float() }], default: []
    field :payment, Payment.t()
  end



  @spec create(id(), NaiveDateTime.t(), Keyword.t()) :: t()

  def create(id, create_at, sku_list \\ [], payment \\ nil) do
    %__MODULE__{
      id: id,
      create_at: create_at,
      rate: Keyword.values(sku_list) |> List.foldl(0, &+/2),
      sku_list: sku_list,
      payment: payment
    }
  end



  @spec get_payment(t()) :: Payment.t() | nil

  def get_payment(sales_order),
    do: sales_order.payment



  @spec add_payment(t(), Payment.t()) :: t()

  def add_payment(sales_order, payment),
    do: %__MODULE__{
          sales_order |
          payment: payment
    }



  @spec get_by(t(), String.t()) :: t() | nil
  
  def get_by(sales_order, sku) do

    case Keyword.get(sales_order.sku_list, sku) do

      [] -> nil

      _ -> sales_order
    end
  end


end
