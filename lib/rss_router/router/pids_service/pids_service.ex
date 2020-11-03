defmodule RssRouter.Router.PidsService do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get_pid(name) do
    Agent.get(__MODULE__, fn pids -> Map.get(pids, name) end)
  end

  def set_pid(name, pid) do
    Agent.update(__MODULE__, fn pids -> Map.put(pids, name, pid) end)
  end
end
