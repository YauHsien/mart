defmodule M.BackOffice.Worker do
	use GenServer

  def start_link(args), do: GenServer.start_link(__MODULE__, args)





  @impl true

  def init(_args) do



    {:ok, %{
     }}
  end



  @impl true

  def handle_info(msg, state)

  def handle_info(_msg, state),
    do: {:noreply, state}

end
