defmodule ExWubook.Bookings do
  @moduledoc """
  API Methods for Booking operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  alias ExWubook.Meta
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @doc """
      Setup push callback url
      """
      @spec push_activation(%Token{}, String.t(), 0 | 1) :: {:ok, nil, %Meta{}} | {:error, any(), %Meta{}}
      def push_activation(%Token{token: token, lcode: lcode}, url, test \\ 0) do
        with {:ok, _, meta} <- Query.send("push_activation", [token, lcode, url, test]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Get push callback url
      """
      @spec push_url(%Token{}) :: {:ok, String.t(), %Meta{}} | {:error, any(), %Meta{}}
      def push_url(%Token{token: token, lcode: lcode}) do
        with {:ok, [url], meta} <- Query.send("push_url", [token, lcode]) do
          {:ok, url, meta}
        end
      end

      @doc """
      Fetch new bookings
      """
      @spec fetch_new_bookings(%Token{}, 0 | 1, 0 | 1) :: {:ok, list(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_new_bookings(%Token{token: token, lcode: lcode}, ancillary \\ 0, mark \\ 1) do
        with {:ok, [bookings], meta} <-
               Query.send("fetch_new_bookings", [token, lcode, ancillary, mark]) do
          {:ok, bookings, meta}
        end
      end

      @doc """
      Mark bookings as received
      """
      @spec mark_bookings(%Token{}, list()) :: {:ok, nil, %Meta{}} | {:error, any(), %Meta{}}
      def mark_bookings(%Token{token: token, lcode: lcode}, reservation_codes) do
        with {:ok, _, meta} <- Query.send("mark_bookings", [token, lcode, reservation_codes]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Fetch bookings
      """
      @spec fetch_bookings(%Token{}, Date.t() | nil, Date.t() | nil, 0 | 1 | nil, 0 | 1 | nil) ::
              {:ok, list(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_bookings(
            %Token{token: token, lcode: lcode},
            dfrom \\ nil,
            dto \\ nil,
            on_created \\ 0,
            ancillary \\ 1
          ) do
        with {:ok, [bookings], meta} <-
               Query.send("fetch_bookings", [token, lcode, date_format(dfrom), date_format(dto), on_created, ancillary]) do
          {:ok, bookings, meta}
        end
      end

      @doc """
      Fetch booking codes
      """
      @spec fetch_bookings_codes(%Token{}, Date.t(), Date.t(), 0 | 1) ::
              {:ok, list(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_bookings_codes(%Token{token: token, lcode: lcode}, dfrom, dto, on_created \\ 1) do
        with {:ok, [codes], meta} <-
               Query.send("fetch_bookings_codes", [token, lcode, date_format(dfrom), date_format(dto), on_created]) do
          {:ok, [codes], meta}
        end
      end

      @doc """
      Fetch booking by code
      """
      @spec fetch_booking(%Token{}, integer(), 0 | 1) :: {:ok, map(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_booking(%Token{token: token, lcode: lcode}, rcode, ancillary \\ 0) do
        with {:ok, [[booking]], meta} <- Query.send("fetch_booking", [token, lcode, rcode, ancillary]) do
          {:ok, booking, meta}
        else
          {:ok, _, meta} -> {:error, :booking_is_not_found, meta}
        end
      end

      @doc """
      Get fount symbols
      """
      @spec get_fount_symbols(%Token{}) :: {:ok, list(), %Meta{}} | {:error, any(), %Meta{}}
      def get_fount_symbols(%Token{token: token, lcode: lcode}) do
        with {:ok, [fount_symbols], meta} <- Query.send("get_fount_symbols", [token, lcode]) do
          {:ok, fount_symbols, meta}
        end
      end

      @doc """
      Cancel reservation
      """
      @spec cancel_reservation(%Token{}, integer(), String.t() | nil) ::
              {:ok, nil, %Meta{}} | {:error, any(), %Meta{}}
      def cancel_reservation(%Token{token: token, lcode: lcode}, rcode, reason \\ nil) do
        with {:ok, _, meta} <- Query.send("cancel_reservation", [token, lcode, rcode, reason]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Create reservation
      """
      @spec new_reservation(%Token{}, map()) :: {:ok, nil, %Meta{}} | {:error, any(), %Meta{}}
      def new_reservation(%Token{token: token, lcode: lcode}, args) do
        with {:ok, _, meta} <-
               Query.send("new_reservation", [
                 token,
                 lcode,
                 # Required arguments
                 (if args[:dfrom], do: date_format(args[:dfrom]), else: nil),
                 (if args[:dto], do: date_format(args[:dto]), else: nil),
                 args[:rooms] || nil,
                 args[:customer] || nil,
                 args[:amount] || 0,
                 # Optional arguments
                 args[:origin] || "xml",
                 args[:ccard] || 0,
                 args[:ancillary] || 0,
                 args[:guests] || 0,
                 args[:ignore_restrs] || 0,
                 args[:ignore_avail] || 0
               ]) do
          {:ok, nil, meta}
        end
      end
    end
  end
end
