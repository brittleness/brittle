defmodule Brittle.Web.RunView do
  use Brittle.Web, :view
  alias Brittle.Run

  def short_revision(%Run{revision: revision}) do
    String.slice(revision, 0..6)
  end

  def human_duration(%Run{duration: duration}) when duration >= 1_000_000 do
    "#{Float.round(duration / 1_000_000, 2)} s"
  end

  def human_duration(%Run{duration: duration}) when duration >= 1_000 do
    "#{Float.round(duration / 1_000, 2)} ms"
  end

  def human_duration(%Run{duration: duration}) do
    "#{duration} μs"
  end

  def duration_time_component(%Run{duration: duration}) do
    "#{Float.round(duration / 1_000_000, 3)} s"
  end
end
