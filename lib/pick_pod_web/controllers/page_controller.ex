defmodule PickPodWeb.PageController do
  use PickPodWeb, :controller

  alias PickPod.Waitlist
  alias PickPod.Email

  def home(conn, _params) do
    changeset = Waitlist.change_waitlist_email()
    form_status = if Phoenix.Flash.get(conn.assigns.flash, :info) == "success", do: :success, else: nil
    render(conn, :home, changeset: changeset, form_status: form_status)
  end

  def testimonials(conn, _params) do
    render(conn, :testimonials)
  end

  def subscribe(conn, %{"waitlist_email" => email_params}) do
    case Waitlist.subscribe_email(email_params) do
      {:ok, waitlist_email} ->
        # Send welcome email asynchronously
        Task.start(fn -> Email.send_welcome_email(waitlist_email.email) end)

        conn
        |> put_flash(:info, "success")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :home, changeset: changeset, form_status: :error)
    end
  end
end
