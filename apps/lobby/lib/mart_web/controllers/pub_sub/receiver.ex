defmodule M.LobbyWeb.Controllers.PubSub.Receiver do
	use GenServer


  def start_link(args),
    do: GenServer.start_link(__MODULE__, args, name: __MODULE__)



  def init(args),
    do: {:ok, %{args: args}}



  def handle_call(:hello, _from, state),
    do: {:reply, state, state}



end
