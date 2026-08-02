defmodule PickPodWeb.PageControllerTest do
  use PickPodWeb.ConnCase

  test "GET / renders the updated homepage", %{conn: conn} do
    conn = get(conn, ~p"/")
    document = conn |> html_response(200) |> LazyHTML.from_document()

    assert has_element?(document, "#hero-signup-form")
    assert has_element?(document, "#lifestyle")
    assert has_element?(document, ~s(img[src="/images/pickpod-in-car.webp"]))
    assert has_element?(document, ~s(img[src="/images/glovebox-graveyard.webp"]))
    assert has_element?(document, ~s(a[href="/about"]))

    assert document
           |> LazyHTML.query(".hero-testimonials")
           |> LazyHTML.text() =~ "PickPod helped me turn flossing into a daily habit."
  end

  test "GET /testimonials renders the habit-focused testimonial", %{conn: conn} do
    conn = get(conn, ~p"/testimonials")
    document = conn |> html_response(200) |> LazyHTML.from_document()

    assert has_element?(document, ".testimonials-grid")
    assert has_element?(document, ~s(a[href="/about"]))

    assert document
           |> LazyHTML.query(".testimonials-grid")
           |> LazyHTML.text() =~ "PickPod helped me turn flossing into a daily habit."
  end

  test "GET /about renders the founder story and waitlist CTA", %{conn: conn} do
    conn = get(conn, ~p"/about")
    document = conn |> html_response(200) |> LazyHTML.from_document()

    assert has_element?(document, "#about-page")
    assert has_element?(document, "#why-pickpod")
    assert has_element?(document, "#founder-story")
    assert has_element?(document, ~s(#about-waitlist-cta[href="/#notify"]))

    assert document
           |> LazyHTML.query("#founder-story")
           |> LazyHTML.text() =~ "The Story Behind PickPod"
  end

  defp has_element?(document, selector) do
    document
    |> LazyHTML.query(selector)
    |> Enum.any?()
  end
end
