defmodule MediaBucketWeb.ItemLive.FormComponent do
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
    case Media.update_item(socket.assigns.item, item_params) do
      {:ok, item} ->
        send self(), {:updated_item, item}
        {:noreply, socket |> push_patch(to: Routes.item_index_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
