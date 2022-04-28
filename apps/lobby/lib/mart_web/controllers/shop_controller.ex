defmodule M.LobbyWeb.ShopController do
  @moduledoc """
  全用戶的商家調閱
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.Command
  require M.Core.Common.Resource

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
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_shop(),
        Common.Resource.shop(),
        Common.Command.update(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
