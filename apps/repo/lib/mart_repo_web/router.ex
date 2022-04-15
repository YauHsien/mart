defmodule M.RepoWeb.Router do
  use M.RepoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", M.RepoWeb do
    pipe_through :api
  end
end
