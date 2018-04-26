defmodule Brittle.Repo.Migrations.CreateRuns do
  use Ecto.Migration

  def change do
    create table(:runs) do
      add(:test_count, :integer)
      add(:failure_count, :integer)
      add(:excluded_count, :integer)
      add(:duration, :integer)

      timestamps()
    end
  end
end
