defmodule Brittle.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add(:suite_id, references(:suites))

      add(:module, :string)
      add(:name, :string)
      add(:file, :string)
      add(:line, :integer)

      timestamps()
    end

    alter table(:results) do
      add(:test_id, references(:tests))
    end
  end
end
