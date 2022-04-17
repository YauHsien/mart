defmodule M.Portfolio.Worker do
	use GenServer, async: false
  alias M.Core.Common
  require M.Env
  require M.Portfolio
  alias Phoenix.PubSub

  def start_link(args), do: GenServer.start_link(__MODULE__, args)

  @set_on_network "set on_network"





  @impl true

  def init(_args) do

    [
      "set on_network"
    ] |>
      Enum.map(&( PubSub.subscribe(M.Portfolio.pub_sub(), &1) ))


    {:ok, %{
        on_network: Common.try_connect(M.Env.pub_sub(), M.Portfolio.pub_sub())
     }}
  end



  @impl

  def handle_info(msg, state)

  def handle_info(@set_on_network, state),
	  do: {:noreply, %{state|on_network: true}}

  def handle_info(msg, state),
    do: {:noreply, state}

end
