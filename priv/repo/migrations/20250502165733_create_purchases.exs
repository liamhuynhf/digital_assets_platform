defmodule DigitalAssets.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :price, :decimal
      add :customer_id, references(:users, on_delete: :nothing)
      add :asset_id, references(:assets, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:purchases, [:customer_id])
    create index(:purchases, [:asset_id])
  end
end
