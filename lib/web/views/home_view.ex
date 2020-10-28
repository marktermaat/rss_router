defmodule RssRouter.Web.HomeView do
  use RssRouter.Web, :view

  def timestamp_to_string(:none) do
    "-"
  end

  def timestamp_to_string(timestamp) do
    DateTime.to_iso8601(timestamp)
  end
end
