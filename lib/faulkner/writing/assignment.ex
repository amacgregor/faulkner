defmodule Faulkner.Writing.Assignment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assignment" do
    field :deadline, :naive_datetime
    field :description, :string
    field :started_at, :naive_datetime

    field :status, Ecto.Enum,
      values: [:planned, :writing, :editing, :unpublished, :published, :deleted]

    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [:title, :description, :tags, :status, :started_at, :deadline])
    |> validate_required([:title, :description, :tags, :status, :started_at, :deadline])
  end
end
