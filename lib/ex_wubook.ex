defmodule ExWubook do
  @moduledoc """
  Wubook API implementation
  """
  use ExWubook.Authentication
  use ExWubook.Rooms
  use ExWubook.Availability
  use ExWubook.Prices
  use ExWubook.Restrictions
  use ExWubook.Bookings
  use ExWubook.Extras
  use ExWubook.Policies
  use ExWubook.Channels
  use ExWubook.Transactions
  use ExWubook.Corporate
end
