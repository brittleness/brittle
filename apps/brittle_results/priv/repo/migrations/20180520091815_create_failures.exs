defmodule Brittle.Repo.Migrations.CreateFailures do
  use Ecto.Migration

  def change do
    create table(:failures) do
      add(:result_id, references(:results))

      add(:message, :string)
      add(:code, :string)
      add(:stacktrace, :text)

      timestamps()
    end
  end
end
