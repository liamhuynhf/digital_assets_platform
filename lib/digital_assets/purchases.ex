defmodule DigitalAssets.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias DigitalAssets.Repo

  alias DigitalAssets.Purchases.Purchase

  def list_purchases do
    Repo.all(Purchase)
  end

  def get_purchase!(id) do
    Purchase
    |> preload(:asset)
    |> Repo.get!(id)
  end

  def create_purchase(attrs) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  def update_purchase(%Purchase{} = purchase, attrs) do
    purchase
    |> Purchase.changeset(attrs)
    |> Repo.update()
  end

  def delete_purchase(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  def change_purchase(%Purchase{} = purchase, attrs \\ %{}) do
    Purchase.changeset(purchase, attrs)
  end

  def list_user_purchases(user_id) do
    Purchase
    |> where(customer_id: ^user_id)
    |> preload(:asset)
    |> Repo.all()
  end

  def user_purchased_asset?(user_id, asset_id) do
    Purchase
    |> where([p], p.customer_id == ^user_id and p.asset_id == ^asset_id)
    |> Repo.exists?()
  end
end
