defmodule Faulkner.Post do
  defstruct body: ""

  def render(%__MODULE{} = post, markdown) do
    html = Earmark.as_html!(markdown)
    {:ok, Map.put(post, :body, html)}
  end
end
