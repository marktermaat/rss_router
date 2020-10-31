defmodule RssRouter.RoutingRule do
  @type t :: %__MODULE__{
          uri: String.t(),
          publisher: RssRouter.Publisher
        }

  @enforce_keys [:uri, :publisher]

  defstruct [:uri, :publisher]
end
