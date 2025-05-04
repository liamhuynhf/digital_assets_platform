defmodule DigitalAssets.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :role, :string
    field :password, :string

    has_one :creator, DigitalAssets.Creators.Creator
    has_many :purchases, DigitalAssets.Purchases.Purchase, foreign_key: :customer_id

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :role, :password])
    |> validate_required([:email, :name, :role, :password])
    |> validate_inclusion(:role, ["admin", "creator", "customer"])
    |> unique_constraint(:email)
  end
end
