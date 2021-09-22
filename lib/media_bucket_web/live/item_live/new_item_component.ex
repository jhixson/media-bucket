defmodule MediaBucketWeb.ItemLive.NewItemComponent do
  use MediaBucketWeb, :live_component

  alias MediaBucket.Media

  @impl true
  def update(%{item: item} = assigns, socket) do
    changeset = Media.change_item(item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"item" => item_params}, socket) do
    changeset =
      socket.assigns.item
      |> Media.change_item(item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    item_with_category = item_params |> Map.put("category_id", socket.assigns.item.category_id)
    case Media.create_item(item_with_category) do
      {:ok, _item} ->
        {:noreply,
         socket
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
