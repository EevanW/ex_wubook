defmodule WubookAPI.Availability do
  @moduledoc """
  API Methods for Availability operations
  """
  alias WubookAPI.Token
  # alias WubookAPI.Query

  def update_avail(%Token{token: _token, lcode: _lcode}, _dfrom, _rooms) do
  end

  def update_sparse_avail(%Token{token: _token, lcode: _lcode}, _rooms) do
  end

  def fetch_rooms_values(%Token{token: _token, lcode: _lcode}, _dfrom, _dto, _rooms \\ []) do
  end
end
