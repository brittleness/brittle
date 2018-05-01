defmodule Brittle.Web.SuiteController do
  require Ecto.Query
  use Brittle.Web, :controller
  alias Brittle.{Repo, Suite}

  def index(conn, _params) do
    render conn, "index.html", suites: Repo.all(Suite)
  end
end
