defmodule M.Shop.Resource.Action do
  alias M.Shop.Resource.Action
  alias Phoenix.PubSub

  @type type() :: {:action, atom()}

  @type t() :: %{
    action_type: Action.type(),
    action_id: any(),
    return_addr: PubSub.topic(),
    payload: Action.param()
  }

  @type param() :: %{
    shop_id: any(),
    item_id: any(),
    detail_id: any()
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



  @spec get_action_id :: Float.t()

  def get_action_id,
    do: NaiveDateTime.utc_now()
  |> NaiveDateTime.to_gregorian_seconds()
  |> then(&( case &1 do
               {f, s} -> f + s / 1_000_000
             end ))


  @spec build_return_addr(action_type :: Action.type(), action_id :: any()) :: String.t()

  def build_return_addr(action_type, action_id),
    do: "#{inspect action_type}:#{inspect action_id}:response"


  @spec request(
    action_type :: Action.type(),
    action_id :: any(),
    return_addr :: any(),
    PubSub.t(),
    payload :: Action.param(),
    timeout()
  ) :: result()

  def request(action_type, action_id, return_addr, pub_sub, payload, timeout \\ 5000) do
    PubSub.subscribe(pub_sub, return_addr)
    topic = inspect(action_type)
    PubSub.broadcast!(pub_sub,
      topic,
      %{
        action_type: action_type,
        action_id: action_id,
        return_addr: return_addr,
        payload: payload
      })
    receive do
      %{status: status, payload: _} = result
      when status === :ok or status === :error ->
        PubSub.unsubscribe(pub_sub, topic)
        result
    after
      timeout ->
        PubSub.unsubscribe(pub_sub, topic)
        {:error, :timeout}
    end
  end






  @spec serve(pub_sub :: PubSub.t(), [action_type :: Action.type()]) :: :ok | {:error, term()}

  def serve(pub_sub, action_type_list),
    do: for action_type <- action_type_list, do: PubSub.subscribe(pub_sub, inspect(action_type))




  @spec solve(
    shop :: GenServer.server(),
    action_type :: Action.type(),
    payload :: Action.param()
  ) :: result
  when result: result()

  def solve(shop, action_type, content)


  def solve(_shop, action_shop_listings() = _action_type, %{shop_id: _shop_id} = _content) do
    status= :do_shop_listings # TODO 處理店家資訊的查詢，希望分為二端：如果是 shop gen-server 快取的，就調用 shop gen-server ；否則可往 Repo 方查詢。
    payload = %{}
    %{status: status, payload: payload}
  end


  def solve(_shop, action_shop_item() = _action_type, %{shop_id: _shop_id, item_id: _item_id} = _content) do
    status= :do_shop_item # TODO
    payload = %{}
    %{status: status, payload: payload}
  end


  def solve(_shop, action_shop_item_detail() = _action_type, %{shop_id: _shop_id, item_id: _item_id, detail_id: _detail_id} = _content) do
    status= :do_shop_item_detail # TODO
    payload = %{}
    %{status: status, payload: payload}
  end


  def shop(_shop, _action_type, _content),
    do: %{status: :error}



end
