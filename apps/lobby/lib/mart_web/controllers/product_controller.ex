defmodule M.LobbyWeb.ProductController do
  @moduledoc """
  全用戶的產品調閱
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.Command
  require M.Core.Common.Resource

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
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_shop(),
        Common.Resource.product(),
        Common.Command.update(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
