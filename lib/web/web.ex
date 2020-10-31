defmodule RssRouter.Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: RssRouter.Web
      alias RssRouter.Web.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/web/templates",
        namespace: RssRouter.Web

      use Phoenix.HTML
      import Phoenix.View
      alias RssRouter.Web.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
