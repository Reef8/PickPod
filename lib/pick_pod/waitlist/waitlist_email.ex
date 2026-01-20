defmodule PickPod.Waitlist.WaitlistEmail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "waitlist_emails" do
    field :email, :string
    field :subscribed_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  def changeset(waitlist_email, attrs) do
    waitlist_email
    |> cast(attrs, [:email])
    |> validate_required([:email], message: "Enter Valid Email Address")
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "Enter Valid Email Address")
    |> validate_length(:email, max: 254, message: "Enter Valid Email Address")
    |> unique_constraint(:email, message: "This email is already on the waitlist")
    |> put_subscribed_at()
  end

  defp put_subscribed_at(changeset) do
    if changeset.valid? and is_nil(get_field(changeset, :subscribed_at)) do
      put_change(changeset, :subscribed_at, DateTime.utc_now() |> DateTime.truncate(:second))
    else
      changeset
    end
  end
end
