defmodule M.Domain.ListingsAggregate.Shop do


  use TypedStruct

  @typedoc """
  Object: Shop
  Aggregate: Listings
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :name, String.t(), enforce: true
  end



  @spec create(integer(), NaiveDateTime.t(), String.t()) :: t()

  def create(id, create_at, name) do

    %__MODULE__{
      id: id,
      create_at: create_at,
      name: name
    }
  end


end
