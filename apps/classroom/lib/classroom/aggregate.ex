
defmodule M.Classroom.Aggregate do
  use GenServer


  def start_link(args), do: GenServer.start_link(__MODULE__, args)



  @impl true
  def init(_args) do
    {:ok, %{}}
  end

end
