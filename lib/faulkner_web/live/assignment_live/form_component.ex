defmodule FaulknerWeb.AssignmentLive.FormComponent do
  use FaulknerWeb, :live_component

  alias Faulkner.Writing

  import FaulknerWeb.Helpers.Forms

  @impl true
  def update(%{assignment: assignment} = assigns, socket) do
    changeset = Writing.change_assignment(assignment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"assignment" => assignment_params}, socket) do
    changeset =
      socket.assigns.assignment
      |> Writing.change_assignment(assignment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"assignment" => assignment_params}, socket) do
    save_assignment(socket, socket.assigns.action, assignment_params)
  end

  defp save_assignment(socket, :edit, assignment_params) do
    case Writing.update_assignment(socket.assigns.assignment, assignment_params) do
      {:ok, _assignment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Assignment updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_assignment(socket, :new, assignment_params) do
    case Writing.create_assignment(assignment_params) do
      {:ok, _assignment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Assignment created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
