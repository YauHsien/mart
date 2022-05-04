defmodule M.Domain.ListingsAggregate.SKU do


  use TypedStruct

  @typedoc """
  Object: SKU
  Aggregate: Listings
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :sku, String.t(), enforce: true
  end



  @spec create(integer(), NaiveDateTime.t(), String.t()) :: t()

  def create(id, create_at, sku) do

    %__MODULE__{
      id: id,
      create_at: create_at,
      sku: sku
    }
  end


end
