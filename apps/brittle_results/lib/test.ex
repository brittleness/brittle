defmodule Brittle.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field(:module, :string)
    field(:name, :string)

    timestamps()
  end

  def changeset(test, attributes) do
    cast(test, attributes, ~w(module name))
  end
end
