defmodule M.Domain.PricingAggregate.Promotion do

  @type id() :: integer() | String.t()



  use TypedStruct

  @doc """
  Object: Promotion
  Aggregate: Pricing
  """

  typedstruct do
    field :id, id(), enforce: true
    field :sku, Stirng.t(), default: nil
    field :description, String.t(), default: nil
    field :price, float(), enfoce: true, default: 0.0
  end


  @spec create(id(), String.t(), float()) :: t()

  def create(id, description, price),
    do: %__MODULE__{
          id: id,
          description: description,
          price: price
    }


end
