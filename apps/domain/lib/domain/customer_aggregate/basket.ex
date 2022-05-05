defmodule M.Domain.CustomerAggregate.Basket do
  alias M.Domain.CustomerAggregate.Item



  use TypedStruct

  @typedoc """
  Object: Basket
  Aggregate: Customer
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :update_at, NaiveDateTime.t()
    field :item_list, [Item.t()], default: []
  end



  @spec get_items(t()) :: [Item.t()]
  def get_items(basket) do
    basket.item_list
  end


end
