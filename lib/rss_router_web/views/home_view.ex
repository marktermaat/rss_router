defmodule RssRouterWeb.HomeView do
  use RssRouterWeb, :view

  def timestamp_to_string(:none) do
    "-"
  end

  def timestamp_to_string(timestamp) do
    DateTime.to_iso8601(timestamp)
  end
end
