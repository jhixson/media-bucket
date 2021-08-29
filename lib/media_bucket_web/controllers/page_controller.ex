defmodule MediaBucketWeb.PageController do
  use MediaBucketWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
