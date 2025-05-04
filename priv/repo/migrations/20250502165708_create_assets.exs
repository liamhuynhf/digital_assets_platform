defmodule DigitalAssets.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :title, :string
      add :description, :text
      add :file_url, :string
      add :price, :decimal
      add :creator_id, references(:creators, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:assets, [:creator_id])
  end
end
