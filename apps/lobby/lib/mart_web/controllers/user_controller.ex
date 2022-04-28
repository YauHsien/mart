defmodule M.LobbyWeb.UserController do
  @moduledoc """
  使用者帳戶操作
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.Command
  require M.Core.Common.Resource

  @doc """
  登入頁面
  """
  def new(conn, _params) do
    render(conn, "login.html")
  end

  @doc """
  使用者登入
  """
  def create(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_member(),
        Common.Resource.user(),
        Common.Command.login(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  使用者登出
  """
  def detete(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_member(),
        Common.Resource.user(),
        Common.Command.logout(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
