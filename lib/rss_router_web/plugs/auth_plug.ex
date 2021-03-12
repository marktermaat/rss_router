defmodule RssRouterWeb.Plugs.AuthPlug do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    token = conn |> get_req_header("authorization") |> List.first
    if token == get_token() do
      conn
    else
      conn
      |> send_resp(401, "Unauthorized")
      |> halt()
    end
  end

  defp get_token do
    Application.fetch_env!(:rss_router, :api_token)
  end
end
