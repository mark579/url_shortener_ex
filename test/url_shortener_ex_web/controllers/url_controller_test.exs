defmodule UrlShortenerExWeb.UrlControllerTest do
  use UrlShortenerExWeb.ConnCase

  test "GET /", %{conn: conn} do
    assert_error_sent 404, fn ->
      get(conn, "/api/urls/abc")
    end
  end
end
