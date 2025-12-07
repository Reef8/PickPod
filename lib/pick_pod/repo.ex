defmodule PickPod.Repo do
  use Ecto.Repo,
    otp_app: :pick_pod,
    adapter: Ecto.Adapters.Postgres
end
