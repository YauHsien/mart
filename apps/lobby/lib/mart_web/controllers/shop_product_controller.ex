defmodule M.LobbyWeb.ShopProductController do
  @moduledoc """
  商家的產品全操作功能
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
  產品編輯頁
  """
  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  @doc """
  產品新增頁
  """
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
  產品頁
  """
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  新增產品
  """
  def create(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_shop(),
        Common.Resource.product(),
        Common.Command.create(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end

  @doc """
  更改產品資料
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

  @doc """
  刪除產品
  """
  def delete(conn, params) do
    _result =
      Common.command(
        M.Lobby.pubsub_lobby(),
        M.Lobby.pubsub_shop(),
        Common.Resource.product(),
        Common.Command.delete(Common.Resource.basket(), params)
      )
    conn
    |> send_resp(200, Jason.encode!(params))
  end
end
