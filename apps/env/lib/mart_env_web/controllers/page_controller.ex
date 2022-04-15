defmodule M.EnvWeb.PageController do
  use M.EnvWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
