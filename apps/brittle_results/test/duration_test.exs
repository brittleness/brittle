defmodule Brittle.Results.DurationTest do
  use ExUnit.Case, async: true
  alias Brittle.Results.Duration

  test "to_human/1 returns the duration in seconds for dirations longer than a second" do
    assert Duration.to_human(20_713_727) == "20.71 s"
  end

  test "to_human/1 returns the duration in milliseconds for dirations longer than a millisecond" do
    assert Duration.to_human(713_727) == "713.73 ms"
  end

  test "to_human/1 returns the duration in microseconds for dirations longer than a microsecond" do
    assert Duration.to_human(727) == "727 μs"
  end

  test "to_time_component/1 returns a valid duration time component" do
    # As described in https://www.w3.org/TR/2014/REC-html5-20141028/infrastructure.html#duration-time-component
    assert Duration.to_time_component(20_713_727) == "20.714 s"
  end
end
