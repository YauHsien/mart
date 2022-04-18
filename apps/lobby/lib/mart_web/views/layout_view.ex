defmodule M.LobbyWeb.LayoutView do
  use M.LobbyWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def title(), do: "滴隧 Dhis-Way （假名）線上學習平台"

end
