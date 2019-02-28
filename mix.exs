defmodule WubookAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :wubook_api,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications: [:logger, :httpoison]
    ]
  end

  defp deps do
    [
      {:xmlrpc, "~> 1.3"},
      {:httpoison, "~> 1.4"}
    ]
  end
end
