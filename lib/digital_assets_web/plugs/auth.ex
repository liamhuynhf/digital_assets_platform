defmodule DigitalAssetsWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def authenticate_user(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "Please log in first")
        |> redirect(to: "/login")
        |> halt()

      user_id ->
        assign(conn, :current_user, DigitalAssets.Accounts.get_user!(user_id))
    end
  end

  def require_authenticated_user(conn, _opts) do
    if user_id = get_session(conn, :user_id) do
      assign(conn, :current_user, DigitalAssets.Accounts.get_user!(user_id))
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: "/login")
      |> halt()
    end
  end

  def require_creator_role(conn, _opts) do
    user = conn.assigns[:current_user]

    if user && user.role == "creator" do
      conn
    else
      conn
      |> put_flash(:error, "Creator access required")
      |> redirect(to: "/")
      |> halt()
    end
  end

  def require_customer_role(conn, _opts) do
    user = conn.assigns[:current_user]

    if user && user.role == "customer" do
      conn
    else
      conn
      |> put_flash(:error, "Customer access required")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
