defmodule RssRouter.ErrorView do
  use RssRouter.Web, :view

  def render("403.html", _assigns) do
    "Unauthorized"
  end

  def render("404.html", _assigns) do
    "Not Found"
  end

  def render("500.html", _assigns) do
    "Exception"
  end
end
