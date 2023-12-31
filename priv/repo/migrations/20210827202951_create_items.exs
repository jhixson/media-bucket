defmodule MediaBucket.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :title, :string, null: false
      add :notes, :text, default: ""
      add :rating, :integer
      add :status, :string, default: "pending"

      timestamps()
    end
  end
end
