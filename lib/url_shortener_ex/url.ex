defmodule UrlShortenerEx.Url do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias UrlShortenerEx.Url
  alias UrlShortenerEx.Repo

  schema "urls" do
    field :raw, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:raw, :slug])
    |> validate_required([:raw, :slug])
    |> validate_url(:raw)
  end

  def create_url(raw_url) do
    url = Url.changeset(%Url{}, %{slug: generate_slug(), raw: raw_url})
    Repo.insert(url)
  end

  def validate_url(changeset, field) do
    validate_change(changeset, field, fn _, value ->
      uri = URI.parse(value)
      case !!(uri.host && uri.path && uri.scheme) do
        true ->
          []
        false ->
          [{field, "URL is not Valid"}]
      end
    end)
  end

  def slug_exists(slug) do
    count = Repo.one(from u in Url, where: u.slug == ^slug, select: count(u.id))
    case count do
      0 -> false
      1 -> true
    end
  end

  defp generate_slug(slug) do
    exists = Url.slug_exists(slug)
    case exists do
      false -> slug
      true -> generate_slug()
    end
  end

  defp generate_slug do
    valid_chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    slug = for _ <- 1..15, into: "", do: <<Enum.random(valid_chars)>>
    generate_slug(slug)
  end
end
