defmodule FaulknerWeb.AssignmentLiveTest do
  use FaulknerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Faulkner.WritingFixtures

  @create_attrs %{
    deadline: %{day: 7, month: 11, year: 2021},
    description: "some description",
    started_at: %{day: 7, month: 11, year: 2021},
    status: :planned,
    tags: ["option1"],
    title: "some title"
  }
  @update_attrs %{
    deadline: %{day: 18, month: 11, year: 2021},
    description: "some updated description",
    started_at: %{day: 18, month: 11, year: 2021},
    status: :writing,
    tags: ["option2"],
    title: "some updated title"
  }
  @invalid_attrs %{
    deadline: %{day: 30, month: 2, year: 2021},
    description: nil,
    started_at: %{day: 30, month: 2, year: 2021},
    status: nil,
    tags: [],
    title: nil
  }

  defp create_assignment(_) do
    assignment = assignment_fixture()
    %{assignment: assignment}
  end

  describe "Index" do
    setup [:create_assignment]

    test "lists all assignment", %{conn: conn, assignment: assignment} do
      {:ok, _index_live, html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert html =~ "Listing Assignment"
      assert html =~ assignment.description
    end

    test "saves new assignment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("a", "New Assignment") |> render_click() =~
               "New Assignment"

      assert_patch(index_live, Routes.assignment_index_path(conn, :new))

      assert index_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#assignment-form", assignment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_index_path(conn, :index))
    end

    test "updates assignment in listing", %{conn: conn, assignment: assignment} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("#assignment-#{assignment.id} a", "Edit") |> render_click() =~
               "Edit Assignment"

      assert_patch(index_live, Routes.assignment_index_path(conn, :edit, assignment))

      assert index_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#assignment-form", assignment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_index_path(conn, :index))

      assert html =~ "Assignment updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes assignment in listing", %{conn: conn, assignment: assignment} do
      {:ok, index_live, _html} = live(conn, Routes.assignment_index_path(conn, :index))

      assert index_live |> element("#assignment-#{assignment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#assignment-#{assignment.id}")
    end
  end

  describe "Show" do
    setup [:create_assignment]

    test "displays assignment", %{conn: conn, assignment: assignment} do
      {:ok, _show_live, html} = live(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert html =~ "Show Assignment"
      assert html =~ assignment.description
    end

    test "updates assignment within modal", %{conn: conn, assignment: assignment} do
      {:ok, show_live, _html} = live(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Assignment"

      assert_patch(show_live, Routes.assignment_show_path(conn, :edit, assignment))

      assert show_live
             |> form("#assignment-form", assignment: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#assignment-form", assignment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.assignment_show_path(conn, :show, assignment))

      assert html =~ "Assignment updated successfully"
      assert html =~ "some updated description"
    end
  end
end
