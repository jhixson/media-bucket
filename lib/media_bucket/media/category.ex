defmodule MediaBucket.Media.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias MediaBucket.Media.Item

  schema "categories" do
    field :title, :string

    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
