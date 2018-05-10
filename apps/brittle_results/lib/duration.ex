defmodule Brittle.Results.Duration do
  def to_human(duration) when duration >= 1_000_000 do
    to_human_seconds(duration)
  end

  def to_human(duration) when duration >= 1_000 do
    to_human_milliseconds(duration)
  end

  def to_human(duration) do
    to_human_microseconds(duration)
  end

  def to_time_component(duration) do
    to_human_seconds(duration, 3)
  end

  defp to_human_seconds(duration, decimals \\ 2) do
    "#{Float.round(duration / 1_000_000, decimals)} s"
  end

  defp to_human_milliseconds(duration, decimals \\ 2) do
    "#{Float.round(duration / 1_000, decimals)} ms"
  end

  defp to_human_microseconds(duration) do
    Integer.to_string(duration) <> " μs"
  end
end
