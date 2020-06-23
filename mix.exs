defmodule ExWubook.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_wubook,
      version: "0.2.13",
      elixir: "~> 1.7",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "ExWubook",
      source_url: "https://github.com/ChannexIO/ex_wubook"
    ]
  end

  def application do
    [
      applications: [:logger]
    ]
  end

  defp deps do
    [
      {:xmlrpc, "~> 1.4"},
      {:http_client, github: "ChannexIO/http_client"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description() do
    "Wubook API Extension for Elixir"
  end

  defp package() do
    [
      name: "ex_wubook",
      files: ~w(lib config .formatter.exs mix.exs README.md LICENSE),
      maintainers: ["Andrew Judis Yudin"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ChannexIO/ex_wubook"}
    ]
  end
end
