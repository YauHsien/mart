defmodule M.MemberWeb.PageController do
  use M.MemberWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
