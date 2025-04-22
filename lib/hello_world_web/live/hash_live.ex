defmodule HelloWorldWeb.HashLive do
  use HelloWorldWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.simple_form for={%{}} phx-submit="hash">
        <.input name="text" placeholder="Enter text" value={@text} />
        <:actions>
          <.button type="submit" phx-disable-with="Hashing...">Go</.button>
        </:actions>
      </.simple_form>
      <%= if @hash do %>
        <h2>Send Output below to techhires@getdarby.com</h2>
        <br />
        <p class="break-words font-mono font-medium text-lg">
          {@text}: {@hash}
        </p>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, hash: nil, text: nil)
    {:ok, socket}
  end

  @impl true
  def handle_event("hash", %{"text" => text}, socket) do
    hash = :crypto.hash(:sha256, text) |> Base.encode64()
    {:noreply, assign(socket, hash: hash, text: text)}
  end
end
