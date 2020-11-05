defmodule Shared.PublisherFake do
  use Agent

  @behaviour RssRouter.Router.Publisher

  @impl RssRouter.Router.Publisher
  def publish(title, uri) do
    add_call(title, uri)
    :ok
  end

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_call(title, uri) do
    Agent.update(__MODULE__, fn calls -> calls ++ [{title, uri}] end)
  end

  def get_calls() do
    Agent.get(__MODULE__, fn calls -> calls end)
  end
end
