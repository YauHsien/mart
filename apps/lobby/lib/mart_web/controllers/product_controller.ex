defmodule M.LobbyWeb.ProductController do
  @moduledoc """
  全用戶的產品調閱
  """
  use M.LobbyWeb, :controller

  @doc """
  產品全覽
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  產品頁
  """
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  更新產品瀏覽紀錄
  """
  def update(conn, params) do
    conn
    |> send_resp(200, params)
  end
end
