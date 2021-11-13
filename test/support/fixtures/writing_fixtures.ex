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
        "deadline" =>  %{"day" => "07", "month" => "11", "year" => "2021"},
        "description" => "some description",
        "started_at" =>  %{"day" => "07", "month" => "11", "year" => "2021"},
        "status" => :planned,
        "tags" => [],
        "title" => "some title"
      })
      |> Faulkner.Writing.create_assignment()

    assignment
  end
end
