defmodule M.Shop do
  @moduledoc """
  Documentation for `M.Shop`.
  """
  use GenServer
  require M.Shop.Resource.Action
  alias M.Shop.Resource.Action
  alias Phoenix.PubSub




  @spec start_link(name: name :: String.t(), channel: channel :: Phoenix.PubSub.t()) :: GenServer.on_start()

  def start_link(name: name, channel: channel),
    do: GenServer.start_link(
          __MODULE__,
          [name: :"mart:shop:#{name}",
           channel: channel],
          name: :"mart:shop:#{name}")




  @spec init([{:name, GenServer.server()} | {:channel, PubSub.t()}]) :: {:ok, map()} | {:stop, reason :: term()}

  @impl true
  def init(args) do
    channel = Keyword.get(args, :channel)
    Action.serve(channel, [
          Action.action_shop_listings(),
          Action.action_shop_item(),
          Action.action_shop_item_detail()
        ])
    {:ok, %{ name: Keyword.get(args, :name),
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
      payload: payload
    },
    %{
      name: my_name,
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
