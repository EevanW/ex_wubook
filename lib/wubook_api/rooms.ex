defmodule WubookAPI.Rooms do
  @moduledoc """
  API Methods for Room operations
  """
  alias WubookAPI.Token
  alias WubookAPI.Query

  @doc """
  Fetch Rooms
  """
  @spec fetch_rooms(%Token{}, integer() | nil) :: {:ok, list} | {:error, any()}
  def fetch_rooms(%Token{token: token, lcode: lcode}, ancillary \\ 0) do
    with {:ok, [rooms]} <- Query.send("fetch_rooms", [token, lcode, ancillary]) do
      {:ok, rooms}
    end
  end
end
