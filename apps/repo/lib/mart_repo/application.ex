defmodule M.Repo.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: M.Repo.Supervisor]
    Supervisor.start_link(children(), opts)
  end

  defp children() do
    [
      M.RepoWeb.Telemetry,
      M.RepoWeb.Endpoint,
      {Registry, keys: :unique, name: RepoRegistry},
      QueryServer, name: {:via, Registry, {RepoRegistry, RepoQueryServer}}
    ] ++ (
      [:member, :branding, :portfolio, :course, :listing, :sales]
      |> Enum.map(& Supervisor.child_spec(
            {
              serving_request_receiver(&1),
              name: {:via, Registry, {RepoRegistry, key_for_serving_request_receiver(&1)}},
              pubsub_server: M.Repo.pubsub_repo_query(),
              query_server: {:via, Registry, {RepoRegistry, RepoQueryServer}}
            },
          id: srr_id(&1)
          ))
    )
  end

  defp serving_request_receiver(:member), do: M.Repo.MemberServingRequestReceiver
  defp serving_request_receiver(:branding), do: M.Repo.BrandingServingRequestReceiver
  defp serving_request_receiver(:portfolio), do: M.Repo.PortfolioServingRequestReceiver
  defp serving_request_receiver(:course), do: M.Repo.CourseServingRequestReceiver
  defp serving_request_receiver(:listing), do: M.Repo.ListingServingRequestReceiver
  defp serving_request_receiver(:sales), do: M.Repo.SalesServingRequestReceiver

  defp key_for_serving_request_receiver(:member), do: MemberServingRequestReceiver
  defp key_for_serving_request_receiver(:branding), do: BrandingServingRequestReceiver
  defp key_for_serving_request_receiver(:portfolio), do: PortfolioServingRequestReceiver
  defp key_for_serving_request_receiver(:course), do: CourseServingRequestReceiver
  defp key_for_serving_request_receiver(:listing), do: ListingServingRequestReceiver
  defp key_for_serving_request_receiver(:sales), do: SalesServingRequestReceiver

  defp srr_id(term), do: :"srr #{inspect term}"

  @impl true
  def config_change(changed, _new, removed) do
    M.RepoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
