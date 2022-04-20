defmodule M.LobbyWeb.ProductController do
  @moduledoc """
  全用戶的產品調閱
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias M.Core.Common

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
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.shop_pub_sub_name(),
        Common.Resource.product(),
        Common.Command.update(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
