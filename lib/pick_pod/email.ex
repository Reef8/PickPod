defmodule PickPod.Email do
  @moduledoc """
  Email sending module using Resend API.
  """

  @resend_api_url "https://api.resend.com/emails"

  def send_welcome_email(to_email) do
    api_key = Application.get_env(:pick_pod, :resend_api_key)

    body = %{
      from: "PickPod <hello@pickpod.com>",
      to: [to_email],
      subject: "Welcome to the PickPod Waitlist!",
      html: welcome_email_html()
    }

    headers = [
      {"Authorization", "Bearer #{api_key}"},
      {"Content-Type", "application/json"}
    ]

    case Req.post(@resend_api_url, json: body, headers: headers) do
      {:ok, %{status: status}} when status in 200..299 ->
        {:ok, :sent}

      {:ok, %{status: status, body: body}} ->
        {:error, "Failed to send email: #{status} - #{inspect(body)}"}

      {:error, reason} ->
        {:error, "Request failed: #{inspect(reason)}"}
    end
  end

  defp welcome_email_html do
    """
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.6; color: #1d1d1f; max-width: 600px; margin: 0 auto; padding: 40px 20px;">
      <div style="text-align: center; margin-bottom: 40px;">
        <h1 style="font-size: 28px; font-weight: 600; margin: 0; color: #1d1d1f;">PickPod</h1>
      </div>

      <div style="background: #f5f5f7; border-radius: 16px; padding: 32px; margin-bottom: 32px;">
        <h2 style="font-size: 24px; font-weight: 600; margin: 0 0 16px 0; color: #1d1d1f;">You're on the list!</h2>
        <p style="margin: 0 0 16px 0; color: #424245;">
          Thanks for joining the PickPod waitlist. You'll be among the first to know when we launch.
        </p>
        <p style="margin: 0; color: #424245;">
          We're working hard to bring you the perfect car floss pick dispenser. Stay tuned for updates!
        </p>
      </div>

      <div style="text-align: center; color: #86868b; font-size: 14px;">
        <p style="margin: 0 0 8px 0;">Made for people who floss in their car.</p>
        <p style="margin: 0;">&copy; 2025 PickPod. All rights reserved.</p>
      </div>
    </body>
    </html>
    """
  end
end
