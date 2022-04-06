defmodule M.LobbyWeb.PageController do
  use M.LobbyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
