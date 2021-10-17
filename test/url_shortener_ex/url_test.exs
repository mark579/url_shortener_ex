defmodule UrlShortenerExWeb.UrlTest do
  use UrlShortenerExWeb.ConnCase

  alias UrlShortenerEx.Url
  alias UrlShortenerEx.Repo

  describe "URL Model Tests" do
    test "inserts a url" do
      Repo.insert!(%Url{id: 1, slug: "ABC", raw: "https://google.com/abc"})
    end

    test "changes set validates its a url" do
      url = Url.changeset(%Url{}, %{slug: "ABC", raw: "abc"})
      assert url.valid? == false

      url = Url.changeset(%Url{}, %{slug: "ABC", raw: "http://google.com/"})
      assert url.valid? == true
    end

    test "create url generates a slug" do
      {:ok, url} = Url.create_url("http://google.com/abcdefg")
      assert String.length(url.slug) == 15
    end

    test "slug exists" do
      {:ok, url} = Url.create_url("http://google.com/abcdefg")
      assert Url.slug_exists(url.slug) == true
      assert Url.slug_exists("ABC") == false
    end
  end
end
