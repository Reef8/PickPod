defmodule PickPod.Repo.Migrations.CreateWaitlistEmails do
  use Ecto.Migration

  def change do
    create table(:waitlist_emails) do
      add :email, :string, null: false
      add :subscribed_at, :utc_datetime, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:waitlist_emails, [:email])
  end
end
