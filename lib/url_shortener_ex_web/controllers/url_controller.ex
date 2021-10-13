defmodule UrlShortenerExWeb.UrlController do
    use UrlShortenerExWeb, :controller

    import Ecto.Query
    alias UrlShortenerEx.Url
    alias UrlShortenerEx.Repo
  
    def get(conn, %{"slug" => slug}) do
      url = Repo.one(from u in Url, where: u.slug == ^slug, select: [:raw])
      
      if url == nil do
        conn
          |> put_resp_content_type("text/plain")
          |> send_resp(404, "A URL with that slug was not found.")
      end

      redirect(conn, external: url.raw)
    end

    def create(conn, %{"raw_url" => raw_url}) do
        url = Url.changeset(%Url{}, %{slug: generate_slug, raw: raw_url})
        {status, url} = Repo.insert(url)
        case status do
          :ok -> json(conn, %{slug: url.slug})
          :error -> send_resp(conn, 400, "Invalid URL")
        end
    end

    def generate_slug(slug) do
      exists = Url.slug_exists(slug)
      case exists do
        false -> slug
        true -> generate_slug
      end
    end

    def generate_slug do
      valid_chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
      slug = for _ <- 1..15, into: "", do: <<Enum.random(valid_chars)>>
      generate_slug(slug)
    end
  end
  