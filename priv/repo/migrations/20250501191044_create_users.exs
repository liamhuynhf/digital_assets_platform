defmodule DigitalAssets.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :role, :string
      add :password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
