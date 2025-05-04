defmodule DigitalAssetsWeb.AssetController do
  use DigitalAssetsWeb, :controller
  alias DigitalAssets.Assets

  def index(conn, _params) do
    assets = Assets.list_available_assets()
    render(conn, :index, assets: assets)
  end

  def bulk_purchase(conn, %{"selected_assets" => asset_ids}) do
    user_id = conn.assigns.current_user.id

    case Assets.bulk_purchase_assets(user_id, asset_ids) do
      {:ok, purchase_count} ->
        conn
        |> put_flash(:info, "Successfully purchased #{purchase_count} assets")
        |> redirect(to: ~p"/my-purchases")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error processing bulk purchase")
        |> redirect(to: ~p"/assets")
    end
  end

  def bulk_purchase(conn, _params) do
    conn
    |> put_flash(:error, "No assets selected for purchase")
    |> redirect(to: ~p"/assets")
  end
end
