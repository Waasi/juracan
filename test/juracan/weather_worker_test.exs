defmodule WeatherWorkerTest do
  use ExUnit.Case
  alias Juracan.WeatherWorker

  setup do
    {:ok, pid} = GenServer.start_link(WeatherWorker, [])
    {:ok, pid: pid}
  end

  test "start correctly", %{pid: pid} do
    assert Process.alive?(pid) == true
  end

  test "weather for valid location" do
    assert {:ok, _report} = WeatherWorker.report("San Juan, Puerto Rico")
  end

  test "weather for invalid location" do
    assert {:error, _msg} = WeatherWorker.report("mipais")
  end
end
