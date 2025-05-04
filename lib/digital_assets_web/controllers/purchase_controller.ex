defmodule DigitalAssetsWeb.PurchaseController do
  use DigitalAssetsWeb, :controller
  alias DigitalAssets.Purchases
  alias DigitalAssets.Assets

  def index(conn, _params) do
    purchases = Purchases.list_user_purchases(conn.assigns.current_user.id)
    render(conn, :index, purchases: purchases)
  end

  def create(conn, %{"id" => asset_id}) do
    case Purchases.create_purchase(%{
           customer_id: conn.assigns.current_user.id,
           asset_id: asset_id
         }) do
      {:ok, _purchase} ->
        conn
        |> put_flash(:info, "Asset purchased successfully!")
        |> redirect(to: ~p"/my-purchases")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Error purchasing asset")
        |> redirect(to: ~p"/assets")
    end
  end

  def download(conn, %{"id" => purchase_id}) do
    purchase = Purchases.get_purchase!(purchase_id)

    if purchase.customer_id == conn.assigns.current_user.id do
      asset = Assets.get_asset!(purchase.asset_id)

      conn
      |> put_resp_header("content-disposition", ~s(attachment; filename="#{asset.title}"))
      |> redirect(external: asset.file_url)
    else
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: ~p"/my-purchases")
    end
  end
end
