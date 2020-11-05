defmodule Router.RouterTest do
  use ExUnit.Case
  import Shared.Helpers

  alias RssRouter.Router.FeedService.RoutingRule

  setup do
    Shared.PublisherFake.start_link(0)

    :ok
  end

  test "publisher is called" do
    {:ok, _pid} =
      GenServer.start_link(RssRouter.Router.FeedService, %RoutingRule{
        uri: "testuri",
        publisher: Shared.PublisherFake
      })

    test_until_timeout(
      fn ->
        received_calls = Shared.PublisherFake.get_calls()
        assert Enum.at(received_calls, 0) == {"Entity 1", "http://entity1.com"}
        assert Enum.at(received_calls, 1) == {"Entity 2", "http://entity2.com"}
      end,
      10000
    )
  end
end
