defmodule WubookAPI do
  @moduledoc """
  Wubook API implementation
  """
  use WubookAPI.Authentication
  use WubookAPI.Rooms
  use WubookAPI.Availability
  use WubookAPI.Prices
  use WubookAPI.Restrictions
end
