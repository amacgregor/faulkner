defmodule FaulknerWeb.PageController do
  use FaulknerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
