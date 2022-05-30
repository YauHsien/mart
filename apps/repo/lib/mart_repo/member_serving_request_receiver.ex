defmodule M.Repo.MemberServingRequestReceiver do
  use M.Repo.ServingRequestReceiver, domain: :member
  alias Phoenix.PubSub

  @impl true
  def handle_info(msg, state)

  def handle_info(msg, state) do
    require Logger
    Logger.warn("#{inspect msg}")
    {:noreply, state}
  end
end
