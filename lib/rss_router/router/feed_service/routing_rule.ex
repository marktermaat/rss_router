defmodule RssRouter.Router.FeedService.RoutingRule do
  @type t :: %__MODULE__{
          uri: String.t(),
          publisher: RssRouter.Router.Publisher
        }

  @enforce_keys [:uri, :publisher]

  defstruct [:uri, :publisher]
end
