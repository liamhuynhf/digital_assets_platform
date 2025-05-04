defmodule DigitalAssets.Creators.Creator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "creators" do
    belongs_to :user, DigitalAssets.Accounts.User
    has_many :assets, DigitalAssets.Assets.Asset

    timestamps()
  end

  def changeset(creator, attrs) do
    creator
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> unique_constraint(:user_id)
  end
end
