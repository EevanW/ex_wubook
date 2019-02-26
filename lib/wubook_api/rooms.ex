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

  def new_room(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def new_virtual_rooms(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def mod_room(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def mod_virtual_room(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def del_room(%Token{token: _token, lcode: _lcode}, _rid) do
  end

  def room_images(%Token{token: _token, lcode: _lcode}, _rid) do
  end

  def push_update_activation(%Token{token: _token, lcode: _lcode}, _url) do
  end

  def push_update_url(%Token{token: _token, lcode: _lcode}) do
  end
end
