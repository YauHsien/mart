defmodule M.LobbyWeb.UserController do
  @moduledoc """
  使用者帳戶操作
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias M.Core.Common

  @doc """
  登入頁面
  """
  def new(conn, params) do
    render(conn, "login.html")
  end

  @doc """
  使用者登入
  """
  def create(conn, params) do
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.member_pub_sub_name(),
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
    result =
      Common.command(
        Common.lobby_pub_sub_name(),
        Common.member_pub_sub_name(),
        Common.Resource.user(),
        Common.Command.logout(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
