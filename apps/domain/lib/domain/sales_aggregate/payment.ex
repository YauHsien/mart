defmodule M.Domain.SalesAggregate.Payment do

  @type id() :: integer() | String.t()



  use TypedStruct

  @doc """
  Object: Payment
  Aggregate: Sales
  """

  typedstruct do
    field :id, id(), enforce: true
    field :create_at, NaiveDateTime.t(), enforce: true
    field :amount, float(), enforce: true
  end



  def create(id, create_at, amount) do
    %__MODULE__{
      id: id,
      create_at: create_at,
      amount: amount
    }
  end


end
