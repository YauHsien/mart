defmodule M.Shop do
  @moduledoc """
  Documentation for `M.Shop`.
  """
  use GenServer



  @spec start_link(name: name :: String.t(), channel: channel :: Phoenix.PubSub.t(), registry: registry :: Registry.t()) :: GenServer.on_start()

  def start_link(name: :host, channel: channel, registry: registry),
    do: GenServer.start_link(__MODULE__, [id: :host, channel: channel, registry: registry])
  def start_link(name: name, channel: channel, registry: registry),
    do: GenServer.start_link(__MODULE__, [id: name, channel: channel, registry: registry])




  @spec init([{:id, any()} | {:channel, Phoenix.PubSub.t()} | {:registry, Registry.t()}]) :: {:ok, map()} | :ignore

  @impl true
  def init(args),
    do: Keyword.get(args, :id)
    |> maybe_init(args)

  @spec maybe_init(id :: any(), [{:id, any()} | {:channel, Phoenix.PubSub.t()} | {:registry, Registry.t()}]) :: {:ok, map()} | :ignore
  defp maybe_init(nil, _args), do: :ignore
  defp maybe_init(id, args),
    do: args
    |> then(&( do_init(id, Keyword.get(&1,:channel), Keyword.get(&1,:registry)) ))

  @spec do_init(id :: any(), channel :: Phoenix.PubSub.t(), registry :: Registry.t()) :: {:ok, map()}
  defp do_init(id, channel, registry),
    do: Registry.register(registry, "#{__MODULE__}:#{id}", self())
    |> then(&( case &1 do
                 {:ok, _pid} ->
                   {:ok, %{id: id, channel: channel, registry: registry}}
                 {:error, {:already_registered, _pid}} ->
                   {:ok, %{id: id, channel: channel, registry: registry}}
               end ))





  @impl true
  def handle_call(request, from, state) do
	  {:reply, state, state}
  end

end
