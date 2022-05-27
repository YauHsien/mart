defmodule M.Repo.BrandingServingRequestReceiver do
  use M.Repo.ServingRequestReceiver, domain: :branding
  alias Phoenix.PubSub

  @impl true
  def handle_info(msg, state)

  def handle_info(_msg, state), do: {:noreply, state}
end
