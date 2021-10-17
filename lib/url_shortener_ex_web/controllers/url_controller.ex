defmodule UrlShortenerExWeb.UrlController do
  use UrlShortenerExWeb, :controller

  import Ecto.Query
  alias UrlShortenerEx.Url
  alias UrlShortenerEx.Repo

  def get(conn, %{"slug" => slug}) do
    url = Repo.one(from(u in Url, where: u.slug == ^slug, select: [:raw]))

    case url do
      nil -> redirect(conn, to: "/?status=NOT_FOUND")
      _ -> redirect(conn, external: url.raw)
    end
  end

  def create(conn, %{"raw" => raw}) do
    {status, url} = Url.create_url(raw)

    case status do
      :ok ->
        json(conn, %{slug: url.slug})

      :error ->
        send_resp(
          conn |> put_resp_content_type("application/json"),
          400,
          Jason.encode!(%{"error" => "Invalid URL"})
        )
    end
  end
end
