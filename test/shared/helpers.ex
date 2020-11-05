defmodule Shared.Helpers do
  import ExUnit.Assertions

  def test_until_timeout(_assertion, milliseconds) when milliseconds <= 0 do
    assert false, "Operation took too long."
  end

  def test_until_timeout(assertion, milliseconds) do
    try do
      assertion.()
      :ok
    rescue
      _ ->
        :timer.sleep(100)
        test_until_timeout(assertion, milliseconds - 100)
    end
  end
end
