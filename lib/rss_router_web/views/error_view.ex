defmodule RssRouterWeb.ErrorView do
  use RssRouterWeb, :view

  def render("403.html", _assigns) do
    "Unauthorized"
  end

  def render("404.html", assigns) do
    assigns.reason.message
  end

  def render("500.html", _assigns) do
    "Exception"
  end
end
