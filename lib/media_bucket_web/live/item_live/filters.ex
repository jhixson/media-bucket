defmodule MediaBucketWeb.ItemLive.Filters do
  use MediaBucketWeb, :live_component

  def render(assigns) do
    ~H"""
    <aside id="filters" x-data="{open: false}">
      <div class="filters-overlay" :class="open && 'open'"></div>
      <button class="absolute top-0 right-8" aria-label="Toggle filters" @click="open = true">
        <i class="fas fa-filter"></i>
      </button>

      <section class="fixed top-0 right-0 w-1/5 h-full bg-gray-600 filters-sidebar z-20" x-cloak x-show="open" @click.outside="console.log('toggle'); open = false"
            x-transition:enter="transition ease-out duration-300"
            x-transition:enter-start="opacity-0 transform translate-x-16"
            x-transition:enter-end="opacity-100 transform translate-x-0"
            x-transition:leave="transition ease-in duration-200"
            x-transition:leave-start="opacity-100 transform translate-x-0"
            x-transition:leave-end="opacity-0 transform translate-x-16">
        <.form let={f} for={:filters} class="px-8 py-12" phx-change="update-filters">
          <%= select f, :rating, [One: 1, Two: 2, Three: 3, Four: 4, Five: 5], prompt: "Rating", selected: @filters["rating"], class: "custom-select appearance-none w-full mb-6 px-0 pr-3 py-1 bg-gray-600 border-b" %>
          <%= select f, :status, Ecto.Enum.mappings(MediaBucket.Media.Item, :status) |> Enum.map(fn {k, v} -> {String.capitalize(v), k} end), prompt: "Status", selected: @filters["status"], class: "custom-select appearance-none w-full px-0 pr-3 py-1 bg-gray-600 border-b" %>
        </.form>
      </section>
    </aside>
    """
  end
end
