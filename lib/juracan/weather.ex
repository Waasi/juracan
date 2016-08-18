defmodule Juracan.Weather do
  @moduledoc """
  The Juracan Weather Moduel fetches the weather
  report for a given location.

  ## Methods
      fetch/1
  """

  ######
  # Client API
  #####

  @doc """
  The fetch/1 method accepts a location string with
  the following formats "city, country", "state country",
  "city, state", "city", "state", "country" and returns
  a string containing a simple weather report.

  ## Examples
      iex> Juracan.Weather.fetch("San Juan, Puerto Rico")
      {:ok, "Partly Cloudy"}\n

      iex> Juracan.Weather.fetch("noexiste")
      :error
  """

  def fetch(location) do
    location |> report
  end

  #####
  # Private Helper Methods
  #####

  defp report(location) do
    location |> url_for |> HTTPoison.get |> parse_response
  end

  defp url_for(location) do
    "https://api.apixu.com/v1/current.json?key=#{Application.get_env(:juracan, :weather_api_key)}&q=#{location}"
    |> URI.encode
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> Poison.decode! |> generate_report
  end
  defp parse_response(_), do: :error

  defp generate_report(json) do
    report = json["current"]["condition"]["text"]
    if report != nil, do: {:ok, report}, else: :error
  end
end
