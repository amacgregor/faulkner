defmodule FaulknerWeb.AssignmentLive.Write do
  use FaulknerWeb, :live_view

  alias Faulkner.Writing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:assignment, Writing.get_assignment!(id))}
  end
end
