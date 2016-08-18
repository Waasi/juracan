defmodule Juracan.WeatherWorker do
  @moduledoc """
  The Juracan WeatherWorker Module implements
  the GenServer and is a Supervised Worker. This
  module provides methods to get the weather report
  of a given location.

  ## Methods
      report/1
  """

  use GenServer
  alias Juracan.Weather

  #####
  # Client API
  ####

  @doc """
  The start_link/0 method starts the server process
  linked to the calling process.

  ## Example:
      iex> {:ok, pid} = Juracan.WeatherWorker.start_link
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  The report/1 method accepts a location string with
  the following formats "city, country", "state country",
  "city, state", "city", "state", "country" and returns
  a string containing a simple weather report.

  ## Examples
      iex> Juracan.WeatherWorker.report("San Juan, Puerto Rico")
      {:ok, "Partly Cloudy"}\n

      iex> Juracan.Weather.fetch("noexiste")
      {:error, "unable to fetch weather report for noexiste"}
  """

  def report(location) do
    GenServer.call(__MODULE__, {:weather_report, location})
  end

  #####
  # GenServer API
  #####

  def handle_call({:weather_report, location}, _from, state) do
    case Weather.fetch(location) do
      {:ok, report} ->
        {:reply, {:ok, report}, state}
      :error ->
        {:reply, {:error, "unable to fetch weather report for #{location}"}, state}
    end
  end
end
