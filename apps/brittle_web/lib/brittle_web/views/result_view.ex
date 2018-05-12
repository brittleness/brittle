defmodule Brittle.Web.ResultView do
  use Brittle.Web, :view

  def status_icon("passed"), do: "✓"
  def status_icon("failed"), do: "✗"
end
