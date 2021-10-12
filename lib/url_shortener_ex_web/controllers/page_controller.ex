defmodule UrlShortenerExWeb.PageController do
  use UrlShortenerExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
