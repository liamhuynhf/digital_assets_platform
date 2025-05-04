defmodule DigitalAssets.Purchases.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    belongs_to :customer, DigitalAssets.Accounts.User
    belongs_to :asset, DigitalAssets.Assets.Asset

    timestamps()
  end

  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, [:customer_id, :asset_id])
    |> validate_required([:customer_id, :asset_id])
  end
end
