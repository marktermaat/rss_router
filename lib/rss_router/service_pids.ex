defmodule RssRouter.ServicePids do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get_pid(uri) do
    Agent.get(__MODULE__, fn pids -> Map.get(pids, uri) end)
  end

  def set_service_pid(uri, pid) do
    Agent.update(__MODULE__, fn pids -> Map.put(pids, uri, pid) end)
  end
end
