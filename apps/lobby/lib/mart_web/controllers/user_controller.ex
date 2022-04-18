defmodule M.LobbyWeb.UserController do
  use M.LobbyWeb, :controller

  def edit(conn, _params) do
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def show(conn, %{id: id}) do
  end

  def create(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, inspect params)
  end

  def update(conn, _params) do
  end
end
