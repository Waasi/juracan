defmodule Juracan.WeatherTest do
  use ExUnit.Case

  alias Juracan.Weather

  test "fetching the weather report for a valid location" do
    assert {:ok, _report} = Weather.fetch("San Juan, Puerto Rico")
  end

  test "fetching the weather report for an invalid location" do
    assert :error = Weather.fetch("unaciudadcualquiera")
  end
end
