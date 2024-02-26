defmodule Orbit.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OrbitWeb.Telemetry,
      Orbit.Repo,
      {Phoenix.PubSub, name: Orbit.PubSub},
      # Start a worker by calling: Orbit.Worker.start_link(arg)
      # {Orbit.Worker, arg},
      # Start to serve requests, typically the last entry
      OrbitWeb.Endpoint
    ]

    :ok = Logster.attach_phoenix_logger()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Orbit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OrbitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
