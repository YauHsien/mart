defmodule M.StudioWeb.PageController do
  use M.StudioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
