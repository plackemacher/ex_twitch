defmodule ExTwitch.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the Twitch V5 API
  """

  def project do
    [
      app: :ex_twitch,
      version: "0.1.0",
      elixir: "~> 1.3",
      name: "ExTwitch",
      description: @description,
      preferred_cli_env: preferred_cli_env(),
      test_coverage: [tool: ExCoveralls],
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      applications: [
        :httpoison,
        :poison
      ]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10"},
      {:poison, "~> 3.0"},
      {:dialyxir, "~> 0.4", only: :dev, runtime: false},
      {:earmark, "~> 1.0", only: :doc},
      {:ex_doc, "~> 0.14.5", only: :doc},
      {:exvcr, "~> 0.6", only: :test},
      {:meck, "~> 0.8", only: :test},
      {:excoveralls, "~> 0.6", only: :test}
    ]
  end

  defp package do
    [
      maintainers: [
        "Pat Lackemacher",
      ],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/plackemacher/ex_twitch"
      }
    ]
  end

  defp preferred_cli_env, do: preferred_cli_env_vcr() ++ preferred_cli_env_coveralls()

  defp preferred_cli_env_vcr do
    [
      vcr: :test,
      "vcr.delete": :test,
      "vcr.check": :test,
      "vcr.show": :test,
    ]
  end

  defp preferred_cli_env_coveralls do
    [
      "coveralls": :test,
      "coveralls.html": :test,
      "coveralls.json": :test,
    ]
  end
end
