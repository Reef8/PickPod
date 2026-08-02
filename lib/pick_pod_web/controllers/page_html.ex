defmodule PickPodWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use PickPodWeb, :html

  attr :active, :atom, default: nil

  def site_nav(assigns) do
    ~H"""
    <nav class="nav" id="navbar" data-site-nav>
      <div class="container">
        <a href={~p"/"} class="nav-logo">PickPod</a>
        <ul class="nav-links" aria-label="Primary navigation">
          <li><a href={~p"/"} aria-current={if @active == :home, do: "page"}>Home</a></li>
          <li><a href={~p"/#features"}>Features</a></li>
          <li>
            <a href={~p"/testimonials"} aria-current={if @active == :testimonials, do: "page"}>
              Testimonials
            </a>
          </li>
          <li><a href={~p"/about"} aria-current={if @active == :about, do: "page"}>About</a></li>
        </ul>
        <a href={~p"/#notify"} class="nav-cta">Get Notified</a>
      </div>
    </nav>
    """
  end

  def site_footer(assigns) do
    ~H"""
    <footer class="footer">
      <div class="container">
        <div class="footer-grid">
          <div>
            <div class="footer-logo">PickPod</div>
            <p class="footer-description">
              The dual-chamber car floss pick dispenser that makes a cleaner daily habit easier.
            </p>
          </div>
          <div>
            <h4 class="footer-heading">Navigation</h4>
            <ul class="footer-links">
              <li><a href={~p"/"}>Home</a></li>
              <li><a href={~p"/#features"}>Features</a></li>
              <li><a href={~p"/testimonials"}>Testimonials</a></li>
              <li><a href={~p"/about"}>About</a></li>
            </ul>
          </div>
          <div>
            <h4 class="footer-heading">Social</h4>
            <ul class="footer-links">
              <li><a href="#">Instagram</a></li>
              <li><a href="#">Twitter</a></li>
              <li><a href="#">Facebook</a></li>
            </ul>
          </div>
          <div>
            <h4 class="footer-heading">Contact</h4>
            <ul class="footer-links">
              <li><a href="mailto:hello@pickpod.com">hello@pickpod.com</a></li>
            </ul>
          </div>
        </div>
        <div class="footer-bottom">
          <p>&copy; {Date.utc_today().year} PickPod. All rights reserved.</p>
          <p>Grab. Floss. Toss.</p>
        </div>
      </div>
    </footer>
    """
  end

  embed_templates "page_html/*"
end
