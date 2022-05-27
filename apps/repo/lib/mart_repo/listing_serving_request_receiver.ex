defmodule M.Repo.ListingServingRequestReciever do
  use M.Repo.ServingRequestReceiver, domain: :listing
  alias Phoenix.PubSub

  @impl true
  def handle_info(msg, state)

  def handle_info(_msg, state), do: {:noreply, state}
end
