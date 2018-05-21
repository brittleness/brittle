defmodule Brittle.Repo.Migrations.CreateSuites do
  use Ecto.Migration

  def change do
    create table(:suites) do
      add(:name, :string)

      timestamps()
    end

    alter table(:runs) do
      add(:suite_id, references(:suites))
    end
  end
end
