defmodule M.Shop.Resource.Action do

  @type t() :: {:action, atom()}

	defmacro action_shop_listings, do: {:action, :'shop:listings'}
  defmacro action_shop_item, do: {:action, :'shop:item'}
  defmacro action_shop_item_details, do: {:action, :'shop:item:details'}
end
