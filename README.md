# ExWubook

Wubook API Extension for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_wubook` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_wubook, "~> 0.2"}
  ]
end
```

## Usage

```elixir
def fetch_rooms do
  with {:ok, token} <- ExWubook.acquire_token("USER", "PASSWORD", LCODE, "PROVIDER_KEY") do
    ExWubook.fetch_rooms(token)
  end
end
```
