defmodule M.Repo.MemberServingRequestReciever do
  use M.Repo.ServingRequestReceiver
  alias Phoenix.PubSub

  @impl true
  def handle_info(msg, state)

  def handle_info(_msg, state), do: {:noreply, state}
end
