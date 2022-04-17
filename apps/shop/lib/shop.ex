defmodule M.Shop do
  @moduledoc """
  Documentation for `M.Shop`.
  """
  use GenServer
  require M.Shop.Resource.Action
  alias M.Shop.Resource.Action
  alias Phoenix.PubSub

  defmacro pub_sub(), do: M.Shop.PubSub



  @spec start_link(
    name: name :: String.t(),
    shop_id: shop_id :: :host | any(),
    channel: channel :: Phoenix.PubSub.t()
  ) :: GenServer.on_start()

  @doc """
  啟動並連結一個 M.Shop gen-server 。

  # 具名參數

  - `{:name, name}` 將轉化為 gen-server 識別名稱 `:"mart:shop:\#{name}"` 。
  - `{:shop_id, shop_id}` 將是業務邏輯識別項，據以指出個別的店舖。
  - `{:channel, channel}` 是 `Phoenix.PubSub` 個體的識別名稱。
  """

  def start_link(name: name, shop_id: shop_id, channel: channel),
    do: GenServer.start_link(
          __MODULE__,
          [name: :"mart:shop:#{name}",
           shop_id: shop_id,
           channel: channel],
          name: :"mart:shop:#{name}")




  @impl true
  @spec init(
    [ {:name, GenServer.server()}
      | {:shop_id, :host | any()}
      | {:channel, PubSub.t()}
    ]
  ) :: {:ok, map()} |  {:stop, reason :: term()}

  def init(args) do

    [
      "set on_network"
    ] |>
      Enum.map(&( PubSub.subscribe(M.Shop.pub_sub(), &1) ))

    channel = Keyword.get(args, :channel)
    Action.serve(channel, [
          Action.action_shop_listings(),
          Action.action_shop_item(),
          Action.action_shop_item_detail()
        ])
    {:ok, %{ name: Keyword.get(args, :name),
             shop_id: Keyword.get(args, :shop_id),
             channel: channel
           }}
  end




  @impl true
  def handle_call(:hello, _from, state) do
	  {:reply, state, state}
  end




  @impl true
  @spec handle_info(msg :: Action.t() | :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info(
    %{
      action_type: action_type,
      action_id: action_id,
      return_addr: return_addr,
      payload: %{shop_id: shop_id} = payload
    },
    %{
      name: my_name,
      shop_id: shop_id,
      channel: pub_sub
    } = state) do

    solution = Action.solve(my_name, action_type, payload)
    result = Map.merge(%{
          return_addr: return_addr,
          action_type: action_type,
          action_id: action_id
                       }, solution)
    PubSub.broadcast!(pub_sub, return_addr, result)

    {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}


end
