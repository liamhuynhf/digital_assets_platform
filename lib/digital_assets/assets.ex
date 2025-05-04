defmodule DigitalAssets.Assets do
  alias DigitalAssets.Assets.Asset
  alias DigitalAssets.Repo
  alias DigitalAssets.Purchases.Purchase

  import Ecto.Query

  def import_assets(creator_id, json_file) do
    with {:ok, json_binary} <- File.read(json_file.path),
         {:ok, assets_data} <- Jason.decode(json_binary) do
      Enum.reduce_while(assets_data, {:ok, []}, fn asset_data, {:ok, acc} ->
        asset_params = %{
          title: asset_data["title"],
          description: asset_data["description"],
          file_url: asset_data["file_url"],
          price: asset_data["price"],
          creator_id: creator_id
        }

        case create_asset(asset_params) do
          {:ok, asset} -> {:cont, {:ok, [asset | acc]}}
          {:error, changeset} -> {:halt, {:error, changeset}}
        end
      end)
    else
      {:error, _reason} = error -> error
    end
  end

  def create_asset(attrs) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert()
  end

  def get_creators_earnings do
    from(a in Asset,
      group_by: a.creator_id,
      select: %{
        creator_id: a.creator_id,
        total_earnings: sum(a.price)
      }
    )
    |> Repo.all()
  end

  def list_available_assets do
    Asset
    |> preload(:creator)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def get_asset!(id) do
    Asset
    |> preload(:creator)
    |> Repo.get!(id)
  end

  def bulk_purchase_assets(user_id, asset_ids) when is_list(asset_ids) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    purchases =
      Enum.map(asset_ids, fn asset_id ->
        %{
          customer_id: user_id,
          asset_id: String.to_integer(asset_id),
          inserted_at: now,
          updated_at: now
        }
      end)

    Repo.transaction(fn ->
      case Repo.insert_all(Purchase, purchases, returning: true) do
        {count, _purchases} when count > 0 -> count
        {0, _} -> Repo.rollback(:no_purchases_created)
        error -> Repo.rollback(error)
      end
    end)
    |> case do
      {:ok, count} -> {:ok, count}
      {:error, reason} -> {:error, reason}
    end
  end

  def bulk_purchase_assets(_user_id, _asset_ids), do: {:error, :invalid_params}
end
