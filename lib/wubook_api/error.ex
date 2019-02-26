defmodule WubookAPI.Error do
  defexception [:reason]
  @type t :: %__MODULE__{reason: any}

  @impl true
  def exception(code),
    do: %__MODULE__{reason: reason_for(code)}

  @impl true
  def message(%__MODULE__{reason: reason}),
    do: humanize_error(reason)

  @doc """
  Convert API Error code to reason atom
  """
  @spec reason_for(neg_integer()) :: atom()
  def reason_for(-1), do: :authentication_failed
  def reason_for(-2), do: :invalid_token
  def reason_for(-3), do: :server_is_busy
  def reason_for(-4), do: :token_request
  def reason_for(-5), do: :token_expired
  def reason_for(-6), do: :lodging_not_active
  def reason_for(-7), do: :internal_error
  def reason_for(-8), do: :token_used_too_many_times
  def reason_for(-9), do: :invalid_rooms
  def reason_for(-10), do: :invalid_lcode
  def reason_for(-11), do: :shortname_has_to_be_unique
  def reason_for(-12), do: :room_not_deleted
  def reason_for(-13), do: :wrong_call
  def reason_for(-14), do: :wrong_number_of_days
  def reason_for(-15), do: :plan_in_use
  def reason_for(-100), do: :invalid_input
  def reason_for(-101), do: :malformed_dates_or_restrictions
  def reason_for(-1000), do: :invalid_lodging_code
  def reason_for(-1001), do: :invalid_dates
  def reason_for(-1002), do: :booking_not_initialized
  def reason_for(-1003), do: :objects_not_available
  def reason_for(-1004), do: :invalid_customer_data
  def reason_for(-1005), do: :invalid_credit_card_data
  def reason_for(-1006), do: :invalid_data
  def reason_for(-1007), do: :no_room_was_requested

  @doc """
  Convert reason atom to human readable string
  """
  @spec humanize_error(atom) :: String.t()
  def humanize_error(:authentication_failed),
    do: "Authentication Failed"

  def humanize_error(:invalid_token),
    do: "Invalid Token"

  def humanize_error(:server_is_busy),
    do: "Server is busy: releasing tokens is now blocked. Please, retry again later"

  def humanize_error(:token_request),
    do: "Token Request: requesting frequence too high"

  def humanize_error(:token_expired),
    do: "Token Expired"

  def humanize_error(:lodging_not_active),
    do: "Lodging is not active"

  def humanize_error(:internal_error),
    do: "Internal Error"

  def humanize_error(:token_used_too_many_times),
    do: "Token used too many times: please, create a new token"

  def humanize_error(:invalid_rooms),
    do: "Invalid Rooms for the selected facility"

  def humanize_error(:invalid_lcode),
    do: "Invalid lcode"

  def humanize_error(:shortname_has_to_be_unique),
    do: "Shortname has to be unique. This shortname is already used"

  def humanize_error(:room_not_deleted),
    do: "Room Not Deleted: Special Offer Involved"

  def humanize_error(:wrong_call),
    do: "Wrong call: pass the correct arguments, please"

  def humanize_error(:wrong_number_of_days),
    do: "Please, pass the same number of days for each room"

  def humanize_error(:plan_in_use),
    do: "This plan is actually in use"

  def humanize_error(:invalid_input),
    do: "Invalid Input"

  def humanize_error(:malformed_dates_or_restrictions),
    do: "Malformed dates or restrictions unrespected"

  def humanize_error(:invalid_lodging_code),
    do: "Invalid Lodging/Portal code"

  def humanize_error(:invalid_dates),
    do: "Invalid Dates"

  def humanize_error(:booking_not_initialized),
    do: "Booking not Initialized: use facility_request()"

  def humanize_error(:objects_not_available),
    do: "Objects not Available"

  def humanize_error(:invalid_customer_data),
    do: "Invalid Customer Data"

  def humanize_error(:invalid_credit_card_data),
    do: "Invalid Credit Card Data or Credit Card Rejected"

  def humanize_error(:invalid_data),
    do: "Invalid Data"

  def humanize_error(:no_room_was_requested),
    do: "No room was requested: use rooms_request()"
end
