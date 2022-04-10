defmodule M.Shop do
  @moduledoc """
  Documentation for `M.Shop`.
  """
  use GenServer



  @spec start_link(name: name :: String.t(), channel: channel :: Phoenix.PubSub.t()) :: GenServer.on_start()

  def start_link(name: name, channel: channel),
    do: GenServer.start_link(
          __MODULE__,
          [name: :"mart:shop:#{name}",
           channel: channel],
          name: :"mart:shop:#{name}")




  @spec init([{:name, String.t()} | {:channel, Phoenix.PubSub.t()}]) :: {:ok, map()} | {:stop, reason :: term()}

  @impl true
  def init(args),
    do: {:ok, %{name: Keyword.get(args,:name),
                channel: Keyword.get(args,:channel)}}




  @impl true
  def handle_call(:hello, _from, state) do
	  {:reply, state, state}
  end

end
