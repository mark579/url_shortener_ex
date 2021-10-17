defmodule UrlShortenerExWeb.UrlControllerTest do
  use UrlShortenerExWeb.ConnCase
  import Ecto.Query
  alias UrlShortenerEx.Url
  alias UrlShortenerEx.Repo

  @create_attrs %{raw: "https://google.com/abc"}
  @invalid_attrs %{raw: "jdfkdjdkj"}

  def fixture(:url) do
    {:ok, url} = Url.create_url(@create_attrs.raw)
    url
  end

  describe "Get URL" do
    setup [:create_url]

    test "GET /api/urls/<slug> redirects when found", %{conn: conn} do
      url = Repo.one(from(u in Url, where: u.raw == ^@create_attrs.raw))
      conn = get(conn, Routes.url_path(conn, :get, url.slug))
      assert redirected_to(conn) == @create_attrs.raw
    end

    test "GET /api/urls/<slug> returns not found when doesn't exist", %{conn: conn} do
      conn = get(conn, Routes.url_path(conn, :get, "ABC"))
      assert redirected_to(conn) == "/?status=NOT_FOUND"
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
