defmodule MediaBucketWeb.ItemLive.Index do
  use MediaBucketWeb, :live_view

  alias MediaBucket.Media
  alias MediaBucket.Media.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :categories, list_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, Media.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Items")
    |> assign(:item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Media.get_item!(id)
    {:ok, _} = Media.delete_item(item)

    {:noreply, push_redirect(socket, to: Routes.item_index_path(socket, :index))}
  end

  defp list_categories do
    Media.list_categories()
  end
end
