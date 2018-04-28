defmodule BrittleWeb.PageController do
  use BrittleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
