defmodule DigitalAssetsWeb.ImportController do
  use DigitalAssetsWeb, :controller

  alias DigitalAssets.Assets
  alias DigitalAssets.Creators

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"file" => file}) do
    creator = Creators.get_creator!(conn.assigns.current_user.id)

    case Assets.import_assets(creator.id, file) do
      {:ok, assets} ->
        conn
        |> put_flash(:info, "#{length(assets)} assets imported successfully.")
        |> redirect(to: ~p"/import")

      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to import assets: #{inspect(reason)}")
        |> render("new.html")
    end
  end
end
