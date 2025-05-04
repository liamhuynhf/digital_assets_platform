defmodule DigitalAssetsWeb.SessionController do
  use DigitalAssetsWeb, :controller

  alias DigitalAssets.Accounts

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.get_user_by_email_and_password(email, password) do
      %Accounts.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Welcome back!")
        |> redirect_based_on_role(user.role)

      _ ->
        conn
        |> put_flash(:error, "Invalid email/password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> put_flash(:info, "Logged out successfully")
    |> redirect(to: ~p"/login")
  end

  defp redirect_based_on_role(conn, role) do
    case role do
      "creator" -> redirect(conn, to: ~p"/import")
      _ -> redirect(conn, to: ~p"/assets")
    end
  end
end
