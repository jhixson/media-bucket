defmodule MediaBucketWeb.ItemLive.Category do
  use MediaBucketWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="md:w-1/3 lg:w-1/4 mx-6 mb-6">
      <div class="flex justify-between items-baseline">
        <h2 class="mb-3 text-lg"><%= @category.title %></h2>
        <p class="text-sm text-gray-400"><%= @category.items |> length() %></p>
      </div>
      <ul>
        <%= for item <- @category.items do %>
          <%= live_component MediaBucketWeb.ItemLive.Item, id: item.id, item: item, status_icon: status_icon(item.status)  %>
        <% end %>
      </ul>
    </div>
    """
  end

  defp status_icon(status) do
    case status do
      :started -> "far fa-minus-square"
      :finished -> "far fa-check-square"
      _ -> "far fa-square"
    end
  end
end
