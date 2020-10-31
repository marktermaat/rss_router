defmodule RssRouter.Publisher do
  @callback publish(String.t(), String.t()) :: :ok | :error
end
