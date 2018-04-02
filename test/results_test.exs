defmodule Brittle.ResultsTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Brittle.Repo)
  end
end
