defmodule M.Domain.CustomerAggregate.UserAccount do
  alias M.Domain.MemberAggregate
  alias M.Domain.CustomerAggregate.Basket



  use TypedStruct

  @typedoc """
  Object: UserAccount (Aggregate root)
  Aggregate: Customer
  """
  typedstruct do
    field :id, integer(), default: nil
    field :create_at, NaiveDateTime.t()
    field :name, MemberAggregate.username(), enforce: true
    field :basket, Basket.t(), default: nil
  end



  @spec create(MemberAggregate.UserAccount.t()) :: t()

  def create(user_account) do

    %__MODULE__{
      id: user_account.id,
      create_at: user_account.inserted_at,
      name: user_account.name
    }
  end



  @spec get_basket(t()) :: Basket.t()

  def get_basket(user_account),
    do: user_account.basket


end
