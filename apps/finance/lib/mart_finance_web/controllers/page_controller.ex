defmodule M.FinanceWeb.PageController do
  use M.FinanceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
