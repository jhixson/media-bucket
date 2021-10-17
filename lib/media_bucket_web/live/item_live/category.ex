defmodule MediaBucketWeb.ItemLive.Category do
  use MediaBucketWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="md:w-1/3 lg:w-1/4 mx-6 mb-6">
      <div class="flex justify-between items-center mb-4">
        <div class="flex space-x-4 items-center">
          <h2 class="text-lg"><%= @category.title %></h2>
          <p class="text-sm text-gray-400"><%= @category.items |> length() %></p>
        </div>
        <%= live_patch to: Routes.item_index_path(@socket, :new, %{category_id: @category.id}), class: "flex items-center space-x-2 px-3 py-1 bg-gray-300 text-gray-700 rounded" do %>
          <span class="font-medium text-sm uppercase">Add Item</span>
          <i class="fas fa-plus-circle"></i>
        <% end %>
      </div>
      <ul>
        <%= for item <- filtered_items(@category.items, @filters) do %>
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

  defp has_rating(item, rating) do
    item_rating = Integer.to_string(item.rating)

    case rating do
      nil -> true
      "" -> true
      ^item_rating -> true
      _ -> false
    end
  end

  defp has_status(item, status) do
    item_status = Atom.to_string(item.status)

    case status do
      nil -> true
      "" -> true
      ^item_status -> true
      _ -> false
    end
  end

  defp filtered_items(items, filters) when filters == %{}, do: items
  defp filtered_items(items, %{"status" => "", "rating" => ""}), do: items
  defp filtered_items(items, %{"status" => status, "rating" => rating}) do
    Enum.filter(items, fn item ->
      with true <- has_rating(item, rating),
           true <- has_status(item, status) do
        true
      else
        _ -> false
      end
    end)
  end
end
