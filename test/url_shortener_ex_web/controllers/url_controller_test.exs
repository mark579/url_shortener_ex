defmodule UrlShortenerExWeb.UrlControllerTest do
  use UrlShortenerExWeb.ConnCase

  alias UrlShortenerEx.Url

  @create_attrs %{raw: "https://google.com/abc", slug: "ABC123"}
  @invalid_attrs %{raw: "jdfkdjdkj", slug: "BDC"}

  def fixture(:url) do
    {:ok, url} = Url.create_url(@create_attrs.raw, @create_attrs.slug)
    url
  end

  describe "non existant URL" do
    test "GET /api/urls/abc", %{conn: conn} do
      assert_error_sent(404, fn ->
        get(conn, Routes.url_path(conn, :get, "ABC"))
      end)
    end
  end

  describe "Get URL" do
    setup [:create_url]

    test "GET /api/urls/<slug> redirects when found", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :get, @create_attrs.slug))
      assert redirected_to(conn) == @create_attrs.raw
    end
  end

  describe "Create URL" do
    test "Create a new URL", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), @create_attrs)
      assert json_response(conn, 200)
    end

    test "Create with invalid URL", %{conn: conn} do
      conn = post(conn, Routes.url_path(conn, :create), @invalid_attrs)
      assert response(conn, 400)
    end
  end

  defp create_url(_) do
    url = fixture(:url)
    %{url: url}
  end
end
