defmodule Brittle.Repo.Migrations.CreateRuns do
  use Ecto.Migration

  def change do
    create table(:runs) do
      add(:digest, :string)
      add(:suite, :string)
      add(:hostname, :string)
      add(:branch, :string)
      add(:revision, :string)
      add(:dirty, :boolean)
      add(:test_count, :integer)
      add(:failure_count, :integer)
      add(:excluded_count, :integer)
      add(:duration, :integer)
      add(:started_at, :utc_datetime)
      add(:finished_at, :utc_datetime)

      timestamps()
    end
  end
end
