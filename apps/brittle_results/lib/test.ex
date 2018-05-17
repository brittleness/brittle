defmodule Brittle.Test do
  use Ecto.Schema
  import Ecto.Changeset
  alias Brittle.{Suite, Result}

  schema "tests" do
    belongs_to(:suite, Suite)
    has_many(:results, Result)

    field(:module, :string)
    field(:name, :string)
    field(:file, :string)
    field(:line, :integer)

    timestamps()
  end

  def changeset(test, attributes) do
    cast(test, attributes, ~w(module name file line suite_id))
  end
end
