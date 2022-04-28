defmodule M.LobbyWeb.Router do
  use M.LobbyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {M.LobbyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", M.LobbyWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/accounts", AccountController, except: [:index, :delete]
    resources "/users/sign-in", UserController, only: [
      :new,    # 登入頁面
      :create, # 登入
      :delete  # 登出
    ]
    resources "/shops", ShopController, only: [
      :index, # 商家全覽
      :show,  # 供應商頁面
      :update # 更改明細資料
    ] do
      resources "/products", ShopProductController # 商家的產品全操作功能
    end
    resources "/products", ProductController, only: [
      :index, # 產品全覽
      :show,  # 產品頁
      :update # 更新產品瀏覽紀錄
    ]
    resources "/users", UserController, only: [] do
      resources "/baskets", BasketController, only: [
        :show,   # 購物籃或銷售訂單頁面
        :create, # 新增品項
        :delete, # 移除品項
        :update, # 結帳
        :index   # 銷售訂單全覽
      ]
      resources "/portfolios", PortfolioController, only: [
        :index,  # 使用歷程全覽
        :show,   # 使用歷程頁面
        :update  # 更新使用歷程
      ]
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: M.LobbyWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
