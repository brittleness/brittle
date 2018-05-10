defmodule Brittle.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add(:module, :string)
      add(:name, :string)

      timestamps()
    end
  end
end
