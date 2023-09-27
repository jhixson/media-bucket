defmodule MediaBucketWeb.ItemLive.Item do
  use MediaBucketWeb, :live_component

  alias MediaBucketWeb.Icons

  def render(assigns) do
    ~H"""
    <li class="flex justify-between items-center space-x-2 mb-4 p-4 bg-gray-700 border border-gray-600 rounded-md">
      <label class="flex items-center gap-2 cursor-pointer" phx-click="update-status" phx-target={@myself}>
        <Icons.empty_circle class={unless (@item.status == :pending), do: "hidden"} />
        <Icons.line_circle class={unless (@item.status == :started), do: "hidden"} />
        <Icons.check_circle class={unless (@item.status == :finished), do: "hidden"} />
        <h3><%= @item.title %></h3>
      </label>
      <%= live_patch to: Routes.item_index_path(@socket, :edit, @item) do %>
        <MediaBucketWeb.Icons.ellipsis />
      <% end %>
    </li>
    """
  end

  def handle_event("update-status", _params, socket) do
    next_status =
      case socket.assigns.item.status do
        nil -> :started
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
