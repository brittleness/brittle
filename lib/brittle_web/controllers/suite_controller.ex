defmodule Brittle.Web.SuiteController do
  use Brittle.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
