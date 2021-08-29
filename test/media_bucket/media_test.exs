defmodule MediaBucket.MediaTest do
  use MediaBucket.DataCase

  alias MediaBucket.Media

  describe "items" do
    alias MediaBucket.Media.Item

    import MediaBucket.MediaFixtures

    @invalid_attrs %{notes: nil, rating: nil, status: nil, title: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Media.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Media.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{notes: "some notes", rating: 42, status: "some status", title: "some title"}

      assert {:ok, %Item{} = item} = Media.create_item(valid_attrs)
      assert item.notes == "some notes"
      assert item.rating == 42
      assert item.status == "some status"
      assert item.title == "some title"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{notes: "some updated notes", rating: 43, status: "some updated status", title: "some updated title"}

      assert {:ok, %Item{} = item} = Media.update_item(item, update_attrs)
      assert item.notes == "some updated notes"
      assert item.rating == 43
      assert item.status == "some updated status"
      assert item.title == "some updated title"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_item(item, @invalid_attrs)
      assert item == Media.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Media.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Media.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Media.change_item(item)
    end
  end
end
