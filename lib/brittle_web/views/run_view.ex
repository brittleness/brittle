defmodule Brittle.Web.RunView do
  use Brittle.Web, :view
  alias Brittle.Run

  def short_revision(%Run{revision: revision}) do
    String.slice(revision, 0..6)
  end
end
