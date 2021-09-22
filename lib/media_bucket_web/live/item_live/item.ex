defmodule MediaBucketWeb.ItemLive.Item do
  use MediaBucketWeb, :live_component

  def render(assigns) do
    ~H"""
    <li class="flex justify-between items-center space-x-2 mb-4 p-4 bg-gray-700 border border-gray-600 rounded-md">
      <label class="flex space-x-2 items-center cursor-pointer" phx-click="update-status" phx-target={@myself}>
        <i class={@status_icon}></i>
        <h3><%= @item.title %></h3>
      </label>
      <%= live_patch to: Routes.item_index_path(@socket, :edit, @item) do %>
        <i class="far fa-ellipsis-h"></i>
      <% end %>
    </li>
    """
  end

  def handle_event("update-status", _params, socket) do
    next_status =
      case socket.assigns.item.status do
        :pending -> :started
        :started -> :finished
        _ -> :pending
      end

    case MediaBucket.Media.update_item(socket.assigns.item, %{status: next_status}) do
      {:ok, _item} ->
        send self(), {:updated_item, %{socket.assigns.item | status: next_status}}
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
