defmodule DigitalAssets.Repo do
  use Ecto.Repo,
    otp_app: :digital_assets,
    adapter: Ecto.Adapters.Postgres
end
