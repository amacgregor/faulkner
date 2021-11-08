defmodule Faulkner.WritingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Faulkner.Writing` context.
  """

  @doc """
  Generate a assignment.
  """
  def assignment_fixture(attrs \\ %{}) do
    {:ok, assignment} =
      attrs
      |> Enum.into(%{
        deadline: ~N[2021-11-07 01:48:00],
        description: "some description",
        started_at: ~N[2021-11-07 01:48:00],
        status: :planned,
        tags: [],
        title: "some title"
      })
      |> Faulkner.Writing.create_assignment()

    assignment
  end
end
