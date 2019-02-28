defmodule WubookAPI do
  @moduledoc """
  Wubook API implementation
  """
  alias WubookAPI.Authentication
  alias WubookAPI.Rooms
  alias WubookAPI.Availability

  defdelegate acquire_token(user, password, provider_key, lcode), to: Authentication
  defdelegate release_token(token), to: Authentication
  defdelegate is_token_valid(token), to: Authentication
  defdelegate provider_info(token), to: Authentication

  defdelegate fetch_rooms(token, ancillary \\ 0), to: Rooms
  defdelegate new_room(token, args), to: Rooms
  defdelegate new_virtual_room(token, args), to: Rooms
  defdelegate mod_room(token, args), to: Rooms
  defdelegate mod_virtual_room(token, args), to: Rooms
  defdelegate del_room(token, rid), to: Rooms
  defdelegate room_images(token, rid), to: Rooms
  defdelegate push_update_activation(token, url), to: Rooms
  defdelegate push_update_url(token), to: Rooms

  defdelegate update_avail(token, dfrom, rooms), to: Availability
  defdelegate update_sparse_avail(token, rooms), to: Availability
  defdelegate fetch_rooms_values(token, dfrom, dto, rooms \\ []), to: Availability
end
