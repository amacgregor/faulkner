defmodule FaulknerWeb.AssignmentLive.Write do
  use FaulknerWeb, :live_view

  alias Faulkner.Writing
  alias Faulkner.Post

  @impl true
  def mount(_params, _session, socket) do
    post = %Post{}
    {:ok, assign(socket, post: post)}
  end

  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:assignment, Writing.get_assignment!(id))}
  end

  def handle_event("render_preview", %{"value" => raw},  %{assigns: %{post: post}} = socket) do
    IO.inspect(raw)

    {:ok, post} = Post.render(post, raw)

    {:noreply, assign(socket, post: post)}
  end
end
