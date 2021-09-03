defmodule Food.Repo do
  use Ecto.Repo,
    otp_app: :food,
    adapter: Ecto.Adapters.Postgres
end
