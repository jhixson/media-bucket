defmodule MediaBucketWeb.ItemLiveTest do
  use MediaBucketWeb.ConnCase

  import Phoenix.LiveViewTest
  import MediaBucket.Factory

  @create_attrs %{notes: "some notes", rating: 42, status: "some status", title: "some title"}
  @update_attrs %{
    notes: "some updated notes",
    rating: 43,
    status: "some updated status",
    title: "some updated title"
  }
  @invalid_attrs %{notes: nil, rating: nil, status: nil, title: nil}

  defp create_item(_) do
    category1 = insert(:category, title: "Movies")
    category2 = insert(:category, title: "TV Shows")
    item1 = insert(:item, title: "Back to the Future", category_id: category1.id)
    item2 = insert(:item, title: "Back to the Future Part 2", category_id: category1.id)
    item3 = insert(:item, title: "Salute Your Shorts", category_id: category2.id)
    %{categories: [category1, category2], items: [item1, item2, item3]}
  end

  describe "Index" do
    setup [:create_item]

    test "lists all items", %{
      conn: conn,
      categories: categories,
      items: items
    } do
      {:ok, _view, html} = live(conn, "/items")
      [category1, category2] = categories
      [item1, item2, item3] = items

      assert html =~ category1.title
      assert html =~ category2.title
      assert html =~ item1.title
      assert html =~ item2.title
      assert html =~ item3.title
    end

    @tag :skip
    test "saves new item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.item_index_path(conn, :index))

      assert index_live |> element("a", "New Item") |> render_click() =~
               "New Item"

      assert_patch(index_live, Routes.item_index_path(conn, :new))

      assert index_live
             |> form("#item-form", item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#item-form", item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.item_index_path(conn, :index))

      assert html =~ "Item created successfully"
      assert html =~ "some notes"
    end

    @tag :skip
    test "updates item in listing", %{conn: conn, item: item} do
      {:ok, index_live, _html} = live(conn, Routes.item_index_path(conn, :index))

      assert index_live |> element("#item-#{item.id} a", "Edit") |> render_click() =~
               "Edit Item"

      assert_patch(index_live, Routes.item_index_path(conn, :edit, item))

      assert index_live
             |> form("#item-form", item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#item-form", item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.item_index_path(conn, :index))

      assert html =~ "Item updated successfully"
      assert html =~ "some updated notes"
    end

    @tag :skip
    test "deletes item in listing", %{conn: conn, item: item} do
      {:ok, index_live, _html} = live(conn, Routes.item_index_path(conn, :index))

      assert index_live |> element("#item-#{item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#item-#{item.id}")
    end
  end

  describe "Show" do
    setup [:create_item]

    @tag :skip
    test "displays item", %{conn: conn, item: item} do
      {:ok, _show_live, html} = live(conn, Routes.item_show_path(conn, :show, item))

      assert html =~ "Show Item"
      assert html =~ item.notes
    end

    @tag :skip
    test "updates item within modal", %{conn: conn, item: item} do
      {:ok, show_live, _html} = live(conn, Routes.item_show_path(conn, :show, item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Item"

      assert_patch(show_live, Routes.item_show_path(conn, :edit, item))

      assert show_live
             |> form("#item-form", item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#item-form", item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.item_show_path(conn, :show, item))

      assert html =~ "Item updated successfully"
      assert html =~ "some updated notes"
    end
  end
end
