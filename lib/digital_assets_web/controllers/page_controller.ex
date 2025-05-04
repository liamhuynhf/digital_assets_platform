defmodule DigitalAssetsWeb.PageController do
  use DigitalAssetsWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
