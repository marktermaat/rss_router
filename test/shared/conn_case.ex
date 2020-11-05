defmodule RssRouterWeb.ConnCase do
  use ExUnit.CaseTemplate

  @table_file "./test/feed_db"

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias RssRouterWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint RssRouterWeb.Endpoint
    end
  end

  setup _tags do
    File.rm(@table_file)

    on_exit(fn ->
      File.rm(@table_file)
    end)

    %{conn: Phoenix.ConnTest.build_conn()}
  end
end
