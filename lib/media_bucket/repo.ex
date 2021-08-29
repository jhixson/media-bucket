defmodule MediaBucket.Repo do
  use Ecto.Repo,
    otp_app: :media_bucket,
    adapter: Ecto.Adapters.Postgres
end
