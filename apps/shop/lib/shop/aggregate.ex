
defmodule M.Shop.Aggregate do
  use GenServer


  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  def init(_args) do
    {:ok, %{}}
  end

end
