defmodule Faulkner.WritingTest do
  use Faulkner.DataCase

  alias Faulkner.Writing

  describe "assignment" do
    alias Faulkner.Writing.Assignment

    import Faulkner.WritingFixtures

    @invalid_attrs %{deadline: nil, description: nil, started_at: nil, status: nil, tags: nil, title: nil}

    test "list_assignment/0 returns all assignment" do
      assignment = assignment_fixture()
      assert Writing.list_assignment() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert Writing.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      valid_attrs = %{deadline: ~N[2021-11-07 01:48:00], description: "some description", started_at: ~N[2021-11-07 01:48:00], status: :planned, tags: [], title: "some title"}

      assert {:ok, %Assignment{} = assignment} = Writing.create_assignment(valid_attrs)
      assert assignment.deadline == ~N[2021-11-07 01:48:00]
      assert assignment.description == "some description"
      assert assignment.started_at == ~N[2021-11-07 01:48:00]
      assert assignment.status == :planned
      assert assignment.tags == []
      assert assignment.title == "some title"
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Writing.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()
      update_attrs = %{deadline: ~N[2021-11-08 01:48:00], description: "some updated description", started_at: ~N[2021-11-08 01:48:00], status: :writing, tags: [], title: "some updated title"}

      assert {:ok, %Assignment{} = assignment} = Writing.update_assignment(assignment, update_attrs)
      assert assignment.deadline == ~N[2021-11-08 01:48:00]
      assert assignment.description == "some updated description"
      assert assignment.started_at == ~N[2021-11-08 01:48:00]
      assert assignment.status == :writing
      assert assignment.tags == []
      assert assignment.title == "some updated title"
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Writing.update_assignment(assignment, @invalid_attrs)
      assert assignment == Writing.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = Writing.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> Writing.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = Writing.change_assignment(assignment)
    end
  end
end
