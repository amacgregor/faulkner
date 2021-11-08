defmodule FaulknerWeb.AssignmentLive.Index do
  use FaulknerWeb, :live_view

  alias Faulkner.Writing
  alias Faulkner.Writing.Assignment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :assignment_collection, list_assignment())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Assignment")
    |> assign(:assignment, Writing.get_assignment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Assignment")
    |> assign(:assignment, %Assignment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Assignment")
    |> assign(:assignment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    assignment = Writing.get_assignment!(id)
    {:ok, _} = Writing.delete_assignment(assignment)

    {:noreply, assign(socket, :assignment_collection, list_assignment())}
  end

  defp list_assignment do
    Writing.list_assignment()
  end
end
