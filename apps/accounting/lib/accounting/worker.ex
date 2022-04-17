defmodule M.Accounting.Worker do
	use GenServer, async: false
  require M.Accounting
  alias M.Core.Common
  require M.Env
  alias Phoenix.PubSub

  def start_link(args), do: GenServer.start_link(__MODULE__, args)

  @set_on_network "set on_network"



  @impl true

  def init(_args) do

    [
      "set on_network"
    ] |>
      Enum.map(&( PubSub.subscribe(M.Accounting.pub_sub(), &1) ))


    {:ok, %{
        on_network: Common.try_connect(M.Env.pub_sub(), M.Accounting.pub_sub())
     }}
  end




  @impl

  def handle_info(msg, state)

  def handle_info(@set_on_network, state),
	  do: {:noreply, %{state|on_network: true}}

  def handle_info(msg, state),
    do: {:noreply, state}



end
