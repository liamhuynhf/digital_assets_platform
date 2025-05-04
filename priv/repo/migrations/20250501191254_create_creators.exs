defmodule DigitalAssets.Repo.Migrations.CreateCreators do
  use Ecto.Migration

  def change do
    create table(:creators) do
      add :user_id, references(:users)

      timestamps()
    end

    create index(:creators, [:user_id])
  end
end
