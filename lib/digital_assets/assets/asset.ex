defmodule DigitalAssets.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :title, :string
    field :description, :string
    field :file_url, :string
    field :price, :decimal

    belongs_to :creator, DigitalAssets.Creators.Creator

    timestamps()
  end

  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:title, :description, :file_url, :price, :creator_id])
    |> validate_required([:title, :file_url, :price, :creator_id])
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
