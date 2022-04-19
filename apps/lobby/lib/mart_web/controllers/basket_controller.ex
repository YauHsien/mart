defmodule M.LobbyWeb.BasketController do
  @moduledoc """
  購物籃或銷售訂單
  """
  use M.LobbyWeb, :controller

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
    # TODO: need implementation
    conn
    |> send_resp(200, params)
  end

  @doc """
  移除訂購品項
  """
  def delete(conn, params) do
    conn
    |> send_resp(200, params)
  end

  @doc """
  結帳
  """
  def update(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, params)
  end

  @doc """
  銷售訂單全覽
  """
  def index(conn, params) do
    render(conn, "sales_orders.html")
  end
end
