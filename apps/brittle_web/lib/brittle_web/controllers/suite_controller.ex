defmodule Brittle.Web.SuiteController do
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite}

  def index(conn, _params) do
    render conn, "index.html", suites: Repo.all(Suite)
  end
end
