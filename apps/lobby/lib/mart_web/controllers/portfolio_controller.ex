defmodule M.LobbyWeb.PortfolioController do
  @moduledoc """
  服務商品的使用歷程
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias M.Core.Common

  @doc """
  使用歷程全覽
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  使用歷程頁面
  """
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  更新使用歷程
  """
  def update(conn, params) do
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.portfolio_order_pub_sub_name(),
        Common.Resource.portfolio(),
        Common.Command.update(Common.Resource.portfolio(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
