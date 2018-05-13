defmodule Brittle.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add(:module, :string)
      add(:name, :string)
      add(:file, :string)
      add(:line, :integer)

      timestamps()
    end
  end
end
