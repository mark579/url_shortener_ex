defmodule UrlShortenerEx.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :raw, :string
      add :slug, :string

      timestamps()
    end
  end
end
