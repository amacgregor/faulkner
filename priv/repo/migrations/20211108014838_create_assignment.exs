defmodule Faulkner.Repo.Migrations.CreateAssignment do
  use Ecto.Migration

  def change do
    create table(:assignment) do
      add :title, :string
      add :description, :string
      add :tags, {:array, :string}
      add :status, :string
      add :started_at, :naive_datetime
      add :deadline, :naive_datetime

      timestamps()
    end
  end
end
