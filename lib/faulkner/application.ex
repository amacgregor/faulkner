defmodule Faulkner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Faulkner.Repo,
      # Start the Telemetry supervisor
      FaulknerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Faulkner.PubSub},
      # Start the Endpoint (http/https)
      FaulknerWeb.Endpoint
      # Start a worker by calling: Faulkner.Worker.start_link(arg)
      # {Faulkner.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Faulkner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FaulknerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
