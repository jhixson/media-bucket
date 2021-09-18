defmodule MediaBucket.ItemTest do
  use MediaBucket.DataCase
  import MediaBucket.Factory

  alias MediaBucket.Media
  alias MediaBucket.Media.Item

  describe "items" do
    @valid_attrs %{status: "pending", title: "some title"}
    @update_attrs %{notes: "some notes", rating: 4, status: "finished"}
    @invalid_attrs %{title: nil}

    test "get_category/1 returns all items for given category" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      %{items: items} = Media.get_category!(category.id)
      assert items == [item]
    end

    test "get_item!/1 returns the item with given id" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert Media.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      category = insert(:category, title: "Movies")
      attrs = Map.merge(@valid_attrs, %{category_id: category.id})
      assert {:ok, %Item{} = item} = Media.create_item(attrs)
      assert item.status == :pending
      assert item.title == "some title"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_item(@invalid_attrs)
    end

    test "create_item/1 without category returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_item(@valid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert {:ok, %Item{} = item} = Media.update_item(item, @update_attrs)
      assert item.notes == "some notes"
      assert item.rating == 4
      assert item.status == :finished
    end

    test "update_item/2 with invalid data returns error changeset" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert {:error, %Ecto.Changeset{}} = Media.update_item(item, @invalid_attrs)
      assert item == Media.get_item!(item.id)
    end

    test "item ratings above 10 are invalid" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert {:error, %Ecto.Changeset{}} = Media.update_item(item, %{rating: 80})
      assert item == Media.get_item!(item.id)
    end

    test "negative item ratings are invalid" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert {:error, %Ecto.Changeset{}} = Media.update_item(item, %{rating: -55})
      assert item == Media.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert {:ok, %Item{}} = Media.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Media.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      category = insert(:category, title: "Movies")
      item = insert(:item, %{category_id: category.id})
      assert %Ecto.Changeset{} = Media.change_item(item)
    end
  end
end
