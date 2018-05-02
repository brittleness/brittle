defmodule Brittle.Web.RunView do
  use Brittle.Web, :view
  alias Brittle.Run

  def short_revision(%Run{revision: revision}) do
    String.slice(revision, 0..6)
  end

  def human_duration(%Run{duration: duration}) do
    "#{Float.round(duration / 1_000_000, 2)} s"
  end
end
