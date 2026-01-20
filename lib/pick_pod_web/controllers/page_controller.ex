defmodule PickPodWeb.PageController do
  use PickPodWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def testimonials(conn, _params) do
    render(conn, :testimonials)
  end
end
