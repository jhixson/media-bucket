defmodule MediaBucket.Media.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias MediaBucket.Media.Category

  schema "items" do
    field :notes, :string, default: ""
    field :rating, :integer, default: 0
    field :status, Ecto.Enum, values: [:pending, :started, :finished]
    field :title, :string

    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :notes, :rating, :status, :category_id])
    |> validate_required([:title, :category_id])
    |> validate_rating()
  end

  defp validate_rating(changeset) do
    case get_change(changeset, :rating) do
      nil -> changeset
        _ -> validate_number(changeset, :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 10)
    end
  end
end
