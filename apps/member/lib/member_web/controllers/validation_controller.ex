defmodule M.MemberWeb.ValidationController do
  use M.MemberWeb, :controller

  def validate(conn, %{"token" => token}) do
    text(conn, token)
  end
end
