defmodule M.MemberWeb.TokenController do
  use M.MemberWeb, :controller

  def login(conn, %{"token" => token}) do
    text(conn, token)
  end

  def login(conn, %{"username" => username, "password" => password}) do
    text(conn, username <> ", " <> password)
  end
end
