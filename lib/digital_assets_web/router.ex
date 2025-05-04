defmodule DigitalAssetsWeb.Router do
  use DigitalAssetsWeb, :router
  import DigitalAssetsWeb.Plugs.Auth
  import DigitalAssetsWeb.Plugs.Admin

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DigitalAssetsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :admin_api_auth do
    plug :require_authenticated_user
    plug :require_admin_role
  end

  scope "/", DigitalAssetsWeb do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/", DigitalAssetsWeb do
    pipe_through [:browser, :require_authenticated_user]
    get "/", PageController, :home

    resources "/assets", AssetController, only: [:index, :show]
    post "/assets/:id/purchase", PurchaseController, :create
    post "/assets/bulk-purchase", AssetController, :bulk_purchase
    get "/my-purchases", PurchaseController, :index
    get "/purchases/:id/download", PurchaseController, :download

    pipe_through [:require_creator_role]
    get "/import", ImportController, :new
    post "/import", ImportController, :create
  end

  scope "/api/admin", DigitalAssetsWeb.Admin do
    pipe_through [:api, :require_authenticated_user, :admin_api_auth]

    get "/creator_earnings", AssetController, :creator_earnings
  end

  # Other scopes may use custom stacks.
  # scope "/api", DigitalAssetsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:digital_assets, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DigitalAssetsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
