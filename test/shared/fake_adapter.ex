defmodule Shared.FakeAdapter do
  def start() do
  end

  def get(_uri, _options, _args) do
    {:ok, %HTTPoison.Response{body: example_rss()}}
  end

  defp example_rss() do
    """
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss version="2.0">

    <channel>
      <title>Test Feed</title>
      <item>
        <title>Entity 1</title>
        <link>http://entity1.com</link>
      </item>
      <item>
      <title>Entity 2</title>
        <link>http://entity2.com</link>
      </item>
    </channel>

    </rss>
    """
  end
end
