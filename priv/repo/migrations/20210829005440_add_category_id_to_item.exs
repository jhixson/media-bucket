defmodule MediaBucket.Repo.Migrations.AddCategoryIdToItem do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :category_id, references(:categories), null: false
    end

    create index(:items, [:category_id])
  end
end
