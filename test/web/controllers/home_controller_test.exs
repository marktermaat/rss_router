defmodule Web.HomeControllerTest do
  use RssRouterWeb.ConnCase
  alias RssRouter.FeedData

  @username Application.fetch_env!(:rss_router, :username)
  @password Application.fetch_env!(:rss_router, :password)

  test "GET / without correct credentials returns unauthorized", %{conn: conn} do
    response =
      conn
      |> using_basic_auth("Not", "correct")
      |> get(Routes.home_path(conn, :index))

    assert response.status == 401
  end

  test "GET / sets correct data", %{conn: conn} do
    {:ok, timestamp, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    :ok = FeedData.insert_feed("new_feed1", timestamp)

    response =
      conn
      |> using_basic_auth(@username, @password)
      |> get(Routes.home_path(conn, :index))

    assert response.assigns.feeds == ["new_feed1"]
    assert response.assigns.latest_entries == [{"new_feed1", timestamp}]
  end

  test "POST /add_feed stores data", %{conn: conn} do
    conn
    |> using_basic_auth(@username, @password)
    |> post(Routes.home_path(conn, :add_feed, feed: "new_feed2"))

    assert FeedData.get_all_latest_entries() == [{"new_feed2", :none}]
  end

  test "GET /delete deletes a given feed", %{conn: conn} do
    {:ok, timestamp, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    :ok = FeedData.insert_feed("new_feed1", timestamp)

    conn
    |> using_basic_auth(@username, @password)
    |> get(Routes.home_path(conn, :delete, Base.encode16("new_feed1")))

    assert FeedData.get_all_latest_entries() == []
  end

  defp using_basic_auth(conn, username, password) do
    put_req_header(conn, "authorization", "Basic " <> Base.encode64("#{username}:#{password}"))
  end
end
