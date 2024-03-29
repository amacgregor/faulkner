defmodule Faulkner.Writing do
  @moduledoc """
  The Writing context.
  """

  import Ecto.Query, warn: false
  alias Faulkner.Repo

  alias Faulkner.Writing.Assignment

  @doc """
  Returns the list of assignment.

  ## Examples

      iex> list_assignment()
      [%Assignment{}, ...]

  """
  def list_assignment do
    Repo.all(Assignment)
  end

  @doc """
  Gets a single assignment.

  Raises `Ecto.NoResultsError` if the Assignment does not exist.

  ## Examples

      iex> get_assignment!(123)
      %Assignment{}

      iex> get_assignment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assignment!(id), do: Repo.get!(Assignment, id)

  @doc """
  Creates a assignment.

  ## Examples

      iex> create_assignment(%{field: value})
      {:ok, %Assignment{}}

      iex> create_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assignment(attrs \\ %{}) do
    attrs =
      attrs
      |> Map.replace("deadline", date_from_map(attrs["deadline"]))
      |> Map.replace("started_at", date_from_map(attrs["started_at"]))

    %Assignment{}
    |> Assignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assignment.

  ## Examples

      iex> update_assignment(assignment, %{field: new_value})
      {:ok, %Assignment{}}

      iex> update_assignment(assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assignment(%Assignment{} = assignment, attrs) do
    attrs =
      attrs
      |> Map.replace("deadline", date_from_map(attrs["deadline"]))
      |> Map.replace("started_at", date_from_map(attrs["started_at"]))

    assignment
    |> Assignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assignment.

  ## Examples

      iex> delete_assignment(assignment)
      {:ok, %Assignment{}}

      iex> delete_assignment(assignment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assignment(%Assignment{} = assignment) do
    Repo.delete(assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assignment changes.

  ## Examples

      iex> change_assignment(assignment)
      %Ecto.Changeset{data: %Assignment{}}

  """
  def change_assignment(%Assignment{} = assignment, attrs \\ %{}) do
    Assignment.changeset(assignment, attrs)
  end

  defp date_from_map(_ = %{"day" => d, "month" => m, "year" => y}) do
    {:ok, date} = Date.new(String.to_integer(y), String.to_integer(m), String.to_integer(d))
    {:ok, datetime} = NaiveDateTime.new(date, ~T[00:00:00])

    datetime
  end

  defp date_from_map(_) do
    NaiveDateTime.local_now()
  end
end
