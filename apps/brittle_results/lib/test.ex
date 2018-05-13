defmodule Brittle.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field(:module, :string)
    field(:name, :string)
    field(:file, :string)
    field(:line, :integer)

    timestamps()
  end

  def changeset(test, attributes) do
    cast(test, attributes, ~w(module name file line))
  end
end
