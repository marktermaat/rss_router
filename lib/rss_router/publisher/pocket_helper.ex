defmodule RssRoutere.PocketHelper do
  @consumer_key Application.fetch_env!(:rss_router, :pocket_consumer_key)
  @access_token Application.fetch_env!(:rss_router, :pocket_access_token)

  @doc """
  This helper function can be used from a console to generate an access token.
  """
  def get_access_token() do
    get_access_token(@access_token)
  end

  defp get_access_token(:empty) do
    IO.puts("Access token already set to #{@access_token}")
  end

  defp get_access_token(_stored_token) do
    {:ok, body} = Pocketeer.Auth.get_request_token(@consumer_key, "http://localhost")
    request_token = body["code"]
    redirect_uri = Pocketeer.Auth.authorize_url(request_token, "http://localhost")
    IO.puts("Redirect URI: #{redirect_uri}")
    IO.gets("Visit the redirect URI and press enter when done")
    {:ok, body} = Pocketeer.Auth.get_access_token(@consumer_key, request_token)
    access_token = body["access_token"]
    IO.puts("Access token: #{access_token}")
  end
end
