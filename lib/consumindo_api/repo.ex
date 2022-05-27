defmodule ConsumindoApi.Repo do
  use Ecto.Repo,
    otp_app: :consumindo_api,
    adapter: Ecto.Adapters.Postgres
end
