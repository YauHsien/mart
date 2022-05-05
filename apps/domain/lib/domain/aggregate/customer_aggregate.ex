defmodule M.Domain.Aggregate.CustomerAggregate do
  alias M.Domain.CustomerAggregate.UserAccount
  alias M.Domain.CustomerAggregate.Basket
  alias M.Domain.CustomerAggregete.Item



  defdelegate create(user_account), to: UserAccount



  defdelegate get_basket(user_account), to: UserAccount



  def get_basket_items(user_account),
    do: Basket.get_items(user_account.basket)



  @spec add_basket(UserAccount.t(), Basket.t()) :: UserAccount.t()

  def add_basket(user_account, basket) do
    %UserAccount{ user_account | basket: basket }
  end



  @spec add_basket_item(UserAccount.t(), Item.t()) :: UserAccount.t()

  def add_basket_item(user_account, item) do

    %UserAccount{
      user_account |
      basket: %Basket {
        user_account.basket |
        update_at: item.create_at,
        item_list: user_account.basket.item_list ++ [item]
      }
    }
  end


end
