# Juracan

A library to get simple weather reports for locations using the [Apixu API](http://apixu.com/).

## Installation

  1. Add `juracan` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:juracan, git: git@github.com:Waasi/juracan.git, tag: "v0.1.0" }]
    end
    ```

  2. Ensure `juracan` is started before using the WeatherWorker in your application:

    ```elixir
    def application do
      [applications: [:juracan]]
    end
    ```

  3. Remember to export the Apixu API Key as follows:

    ```shell
     export WEATHER_API_KEY=<apixu_api_key>
    ```

## Usage

The Juracan module can be used as a Server but also as a simple module.

#### Weather Module

With valid locations:

```elixir
Juracan.Weather.fetch("San Juan, Puerto Rico") ## => {:ok, weather_report}
```

Without valid locations:

```elixir
Juracan.Weather.fetch("no existe") ## => :error
```

#### WeatherWorker

With valid locations:

```elixir
Juracan.WeatherWorker.start_link ## => {:ok, pid}
Juracan.WeatherWorker.report("San Juan, Puerto Rico") ## => {:ok, weather_report}
```

Without valid locations:

```elixir
Juracan.WeatherWorker.start_link ## => {:ok, pid}
Juracan.WeatherWorker.report("no existe") ## => {:ok, error_msg}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/juracan/fork )
2. Create your feature branch (`git checkout -b feature/my_new_feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
