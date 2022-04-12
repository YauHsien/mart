defmodule M.Shop.Resource.Action do
  alias M.Shop.Resource.Action
  alias Phoenix.PubSub

  @type type() :: {:action, atom()}

  @type t() :: %{
    action_type: Action.type(),
    action_id: any(),
    return_addr: PubSub.topic(),
    payload: map()
  }

  @type result() :: %{
    status: :ok | :error,
    payload: any()
  }

	defmacro action_shop_listings, do: {:action, :'shop:listings'}
  defmacro reqpar_shop_listings(shop_id),
    do: %{
          shop_id: shop_id
    }

  defmacro action_shop_item, do: {:action, :'shop:item'}
  defmacro reqpar_shop_item(shop_id, item_id),
    do: %{
          shop_id: shop_id,
          item_id: item_id
    }

  defmacro action_shop_item_detail, do: {:action, :'shop:item:details'}
  defmacro reqpar_shop_item_detail(shop_id, item_id, detail_id),
    do: %{
          shop_id: shop_id,
          item_id: item_id,
          detail_id: detail_id
    }




  @spec serve(pub_sub :: PubSub.t(), [action_type :: Action.type()]) :: :ok | {:error, term()}

  def serve(pub_sub, action_type_list),
    do: for action_type <- action_type_list, do: PubSub.subscribe(pub_sub, inspect(action_type))




  @spec request(action_type :: Action.t(), action_id :: any(), return_addr :: any(), pub_sub :: PubSub.t(), payload :: map()) :: :ok

  def request(action_type, action_id, return_addr, pub_sub, payload) do
    PubSub.broadcast!(pub_sub,
      inspect(action_type),
      %{
        action_type: action_type,
        action_id: action_id,
        return_addr: return_addr,
        payload: payload
      })
  end




  @spec solve(shop :: GenServer.server(), action_type :: Action.t(), payload :: map()) :: result when result: result()

  def solve(shop, action_type, content)


  def solve(_shop, action_shop_listings() = _action_type, %{shop_id: _shop_id} = _content) do
    status: :do_shop_listings # TODO 處理店家資訊的查詢，希望分為二端：如果是 shop gen-server 快取的，就調用 shop gen-server ；否則可往 Repo 方查詢。
    %{status: status, payload: payload}
  end


  def solve(_shop, action_shop_item() = _action_type, %{shop_id: shop_id, item_id: item_id} = _content) do
    status: :do_shop_item # TODO
    %{status: status, payload: payload}
  end


  def solve(_shop, action_shop_item_detail() = _action_type, %{shop_id: shop_id, item_id: item_id, detail_id: detail_id} = _content) do
    status: :do_shop_item_detail # TODO
    %{status: status, payload: payload}
  end


  def shop(_shop, _action_type, _content),
    do: %{status: :error}



end
