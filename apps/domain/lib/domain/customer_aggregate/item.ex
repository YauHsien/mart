defmodule M.Domain.CustomerAggregate.Item do



  use TypedStruct

  @typedoc """
  Object: Item
  Aggregate: Customer
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :sku, String.t()
    field :name, String.t()
    field :lesson_count, integer()
    field :price, float()
  end



end

