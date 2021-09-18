defmodule MediaBucket.Factory do
  use ExMachina.Ecto, repo: MediaBucket.Repo

  def item_factory do
    %MediaBucket.Media.Item{
      title: "Back to the Future",
      status: :pending
    }
  end

  def category_factory do
    %MediaBucket.Media.Category{
      title: "Movies"
    }
  end
end
