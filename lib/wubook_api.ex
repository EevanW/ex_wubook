defmodule WubookAPI do
  @moduledoc """
  Wubook API implementation
  """
  use WubookAPI.Authentication
  use WubookAPI.Rooms
  use WubookAPI.Availability
  use WubookAPI.Prices
  use WubookAPI.Restrictions
  use WubookAPI.Bookings
  use WubookAPI.Extras
  use WubookAPI.Policies
  use WubookAPI.Channels
  use WubookAPI.Transactions
  use WubookAPI.Corporate
end
