defmodule Brittle.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add(:run_id, references(:runs))
      add(:test_id, references(:tests))

      add(:status, :string)
      add(:duration, :integer)

      timestamps()
    end
  end
end
