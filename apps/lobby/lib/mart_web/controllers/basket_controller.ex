defmodule M.LobbyWeb.BasketController do
  @moduledoc """
  購物籃或銷售訂單
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.Command
  require M.Core.Common.Resource

  @doc """
  購物籃或銷售訂單頁面
  """
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  新增訂購品項
  """
  def create(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_sales_order(),
        Common.Resource.basket(),
        Common.Command.add_to(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  移除訂購品項
  """
  def delete(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_sales_order(),
        Common.Resource.basket(),
        Common.Command.remove_from(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  結帳
  """
  def update(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_sales_order(),
        Common.Resource.basket(),
        Common.Command.checkout(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  銷售訂單全覽
  """
  def index(conn, _params) do
    render(conn, "sales_orders.html")
  end
end
