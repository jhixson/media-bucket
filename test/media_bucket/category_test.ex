defmodule MediaBucket.CategoryTest do
  use MediaBucket.DataCase
  import MediaBucket.Factory

  alias MediaBucket.Media
  alias MediaBucket.Media.Category

  describe "categories" do
    @valid_attrs %{title: "cat title"}
    @update_attrs %{title: "new title"}
    @invalid_attrs %{title: nil}

    test "get_category!/1 returns the category with given id" do
      category = insert(:category) |> Repo.preload(:items)
      assert Media.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Media.create_category(@valid_attrs)
      assert category.title == "cat title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = insert(:category, title: "Movies")
      assert {:ok, %Category{} = category} = Media.update_category(category, @update_attrs)
      assert category.title == "new title"
    end

    test "delete_category/1 deletes the category" do
      category = insert(:category)
      assert {:ok, %Category{}} = Media.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Media.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = insert(:category)
      assert %Ecto.Changeset{} = Media.change_category(category)
    end
  end
end
