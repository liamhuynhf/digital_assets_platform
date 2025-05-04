defmodule DigitalAssetsWeb.Admin.AssetController do
  use DigitalAssetsWeb, :controller
  alias DigitalAssets.Assets

  def creator_earnings(conn, _params) do
    creators_earnings = Assets.get_creators_earnings()
    json(conn, creators_earnings)
  end
end
