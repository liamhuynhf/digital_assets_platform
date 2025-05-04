defmodule DigitalAssetsWeb.Plugs.Admin do
  import Plug.Conn
  import Phoenix.Controller

  def require_admin_role(conn, _opts) do
    user = conn.assigns[:current_user]

    if user && user.role == "admin" do
      conn
    else
      conn
      |> put_flash(:error, "Admin access required")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
