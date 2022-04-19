defmodule M.LobbyWeb.UserController do
  use M.LobbyWeb, :controller

  def new(conn, params) do
    render(conn, "login.html")
  end

  def create(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, inspect params)
  end

  def detete(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, inspect params)
  end
end
