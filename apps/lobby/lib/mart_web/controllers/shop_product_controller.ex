defmodule M.LobbyWeb.ShopProductController do
  @moduledoc """
  商家的產品全操作功能
  """

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
    # TODO: need implementation
    conn
    |> send_resp(200, params)
  end

  @doc """
  更改產品資料
  """
  def update(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, params)
  end

  @doc """
  刪除產品
  """
  def delete(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, params)
  end
end
