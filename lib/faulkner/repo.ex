defmodule Faulkner.Repo do
  use Ecto.Repo,
    otp_app: :faulkner,
    adapter: Ecto.Adapters.Postgres
end
