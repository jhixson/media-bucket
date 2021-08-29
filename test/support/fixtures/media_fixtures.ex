defmodule MediaBucket.MediaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MediaBucket.Media` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        notes: "some notes",
        rating: 42,
        status: "some status",
        title: "some title"
      })
      |> MediaBucket.Media.create_item()

    item
  end
end
