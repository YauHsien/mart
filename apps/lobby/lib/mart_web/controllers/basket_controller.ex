defmodule M.LobbyWeb.BasketController do
  @moduledoc """
  購物籃或銷售訂單
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias M.Core.Common

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
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.sales_order_pub_sub_name(),
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
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.sales_order_pub_sub_name(),
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
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.sales_order_pub_sub_name(),
        Common.Resource.basket(),
        Common.Command.checkout(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  銷售訂單全覽
  """
  def index(conn, params) do
    render(conn, "sales_orders.html")
  end
end
