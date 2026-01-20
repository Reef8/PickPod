defmodule PickPod.Waitlist do
  @moduledoc """
  The Waitlist context for managing email signups.
  """

  import Ecto.Query
  alias PickPod.Repo
  alias PickPod.Waitlist.WaitlistEmail

  def subscribe_email(attrs) do
    %WaitlistEmail{}
    |> WaitlistEmail.changeset(attrs)
    |> Repo.insert()
  end

  def change_waitlist_email(waitlist_email \\ %WaitlistEmail{}) do
    Ecto.Changeset.change(waitlist_email)
  end

  def get_by_email(email) do
    Repo.get_by(WaitlistEmail, email: email)
  end

  def list_emails do
    Repo.all(from w in WaitlistEmail, order_by: [desc: w.subscribed_at])
  end

  def count_subscribers do
    Repo.aggregate(WaitlistEmail, :count)
  end
end
