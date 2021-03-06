defmodule Juracan do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Juracan.WeatherWorker, []),
    ]

    opts = [strategy: :one_for_one, name: Juracan.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
