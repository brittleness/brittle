defmodule Brittle.Web.RunView do
  use Brittle.Web, :view
  alias Brittle.Run

  def short_revision(%Run{revision: revision}) do
    String.slice(revision, 0..6)
  end

  def status_icon(%Run{failure_count: 0}), do: "✓"
  def status_icon(%Run{failure_count: _}), do: "✗"

  def status(%Run{failure_count: 0}), do: :passed
  def status(%Run{failure_count: _}), do: :failed
end
