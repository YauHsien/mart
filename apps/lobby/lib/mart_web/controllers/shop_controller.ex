defmodule M.LobbyWeb.ShopController do
  @moduledoc """
  全用戶的商家調閱
  """
  use M.LobbyWeb, :controller

  @doc """
  商家全覽
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  供應商頁面
  """
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  更改商家明細資料
  """
  def update(conn, params) do
    conn
    |> send_resp(200, params)
  end
end
