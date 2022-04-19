defmodule M.LobbyWeb.AccountController do
  @moduledoc """
  帳號管理
  """
  use M.LobbyWeb, :controller

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
  def show(conn, %{id: id}) do
    render(conn, "show.html")
  end

  @doc """
  新增帳號資料
  """
  def create(conn, params) do
    # TODO: need implementation
    conn
    |> send_resp(200, inspect params)
  end

  @doc """
  更改帳號資料
  """
  def update(conn, _params) do
    # TODO: need implementation
    conn
    |> send_resp(200, inspect params)
  end
end
