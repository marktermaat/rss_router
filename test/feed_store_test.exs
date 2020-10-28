defmodule FeedStoreTest do
  use ExUnit.Case
  import RssRouter.FeedStore

  setup do
    data_path = "./test"
    System.put_env("DATA_PATH", data_path)
    File.rm(data_path <> "/feed_data")

    on_exit(fn ->
      File.rm(data_path <> "/feed_data")
    end)

    :ok
  end

  test "Requesting feeds returns an empty array without data" do
    assert get_feeds() == []
  end

  test "Inserted feeds are stored" do
    assert insert_feed("feed1") == :ok
    assert get_feeds() == ["feed1"]
  end

  test "Requesting latest entries returns empty array without data" do
    assert get_feed_latest_timestamp("unknown_feed") == :none
  end

  test "Inserted latest entry timestamps are stored" do
    {:ok, timestamp, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    assert set_feed_latest_timestamp("new_feed1", timestamp) == :ok
    assert get_feed_latest_timestamp("new_feed1") == timestamp
  end

  test "Inserting latest entry timestamps overrides previous values" do
    {:ok, timestamp_old, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    assert set_feed_latest_timestamp("new_feed1", timestamp_old) == :ok
    {:ok, timestamp_new, 0} = DateTime.from_iso8601("2016-01-23T23:50:07Z")
    assert set_feed_latest_timestamp("new_feed1", timestamp_new) == :ok

    assert get_feed_latest_timestamp("new_feed1") == timestamp_new
  end

  test "Requesting all entries returns an empty array without data" do
    assert get_all_latest_entries() == []
  end

  test "Requesting all entries returns stored entries" do
    {:ok, timestamp, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
    assert set_feed_latest_timestamp("new_feed1", timestamp) == :ok

    assert get_all_latest_entries() == [{"new_feed1", timestamp}]
  end
end
