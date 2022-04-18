defmodule M.Repo.Worker do
	use GenServer, async: false
  require M.Core.Common
  alias M.Core.Common
  alias Phoenix.PubSub

  def start_link(args), do: GenServer.start_link(__MODULE__, args)

  @set_on_network "set on_network"





  @impl true

  def init(_args) do

    [
      "set on_network"
    ] |>
      Enum.map(&( PubSub.subscribe(Common.repo_pub_sub_name(), &1) ))


    {:ok, %{
        on_network: Common.try_connect(Common.env_pub_sub_name(), Common.repo_pub_sub_name())
     }}
  end



  @impl

  def handle_info(msg, state)

  def handle_info(@set_on_network, state),
	  do: {:noreply, %{state|on_network: true}}

  def handle_info(msg, state),
    do: {:noreply, state}

end
