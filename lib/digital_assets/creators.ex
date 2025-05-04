defmodule DigitalAssets.Creators do
  @moduledoc """
  The Creators context.
  """

  import Ecto.Query, warn: false
  alias DigitalAssets.Repo

  alias DigitalAssets.Creators.Creator

  def get_creator!(id), do: Repo.get!(Creator, id)
end
