defmodule M.Repo.SalesServingRequestReceiver do
  use M.Repo.ServingRequestReceiver, domain: :sales
  alias Phoenix.PubSub

  @impl true
  def handle_info(msg, state)

  def handle_info(_msg, state), do: {:noreply, state}
end
