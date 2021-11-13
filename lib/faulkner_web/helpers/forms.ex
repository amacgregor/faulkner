defmodule FaulknerWeb.Helpers.Forms do
  import Phoenix.HTML.Form, only: [date_select: 3]
  import Phoenix.HTML, only: [sigil_E: 2]
  require EEx

  @spec formatted_date_select(atom | Phoenix.HTML.Form.t(), atom | binary, keyword) :: any
  def formatted_date_select(form, field, opts \\ []) do
    builder = fn b ->
      [
      b.(:day, []),
      b.(:month, []),
      b.(:year, [])
      ]
    end

    date_select(form, field, [builder: builder] ++ opts)
  end
end
