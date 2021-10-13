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

  def validate_url(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, value ->
      case !!(URI.parse(value).host) do
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
end
