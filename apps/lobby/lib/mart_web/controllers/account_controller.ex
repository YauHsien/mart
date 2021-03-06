defmodule M.LobbyWeb.AccountController do
  @moduledoc """
  帳號管理
  """
  use M.LobbyWeb, :controller
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.Command
  require M.Core.Common.Resource

  @doc """
  變更帳號內容頁面
  """
  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  @doc """
  創立帳號頁面
  """
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
  帳號說明頁面
  """
  def show(conn, %{id: _id}) do
    render(conn, "show.html")
  end

  @doc """
  新增帳號資料
  """
  def create(conn, params) do
    result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_member(),
        Common.Resource.account(),
        Common.Command.create(Common.Resource.account(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(result))
  end

  @doc """
  更改帳號資料
  """
  def update(conn, params) do
    result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_member(),
        Common.Resource.account(),
        Common.Command.update(Common.Resource.account(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(result))
  end
end
