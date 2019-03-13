defmodule ExWubook.Availability do
  @moduledoc """
  API Methods for Availability operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @doc """
      Update Availability Range
      """
      @spec update_avail(%Token{}, Date.t(), list()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_avail(%Token{token: token, lcode: lcode}, dfrom, rooms) do
        # rooms: [%{id: 362671, days: [%{avail: 1}]}]
        with {:ok, _, q, a} <- Query.send("update_avail", [token, lcode, date_format(dfrom), rooms]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update Sparse Availability
      """
      @spec update_sparse_avail(%Token{}, list()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_sparse_avail(%Token{token: token, lcode: lcode}, rooms) do
        # rooms:
        # [{
        #   id: integer(),
        #   days: [
        #     {
        #       date: "DD/MM/YYYY",
        #       avail: integer(),
        #       price: float(),
        #       min_stay: integer(),
        #       min_stay_arrival: integer(),
        #       max_stay: integer()
        #       closed_arrival: boolean(),
        #       closed_departure: boolean(),
        #       closed: booean(),
        #       no_ota: booean()
        #     }
        #   ]
        # }]
        rooms = rooms |> Enum.map(fn el -> Map.put(el, :date, date_format(el.date)) end)
        with {:ok, _, q, a} <- Query.send("update_sparse_avail", [token, lcode, rooms]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Fetch room values
      """
      @spec fetch_rooms_values(%Token{}, Date.t(), Date.t(), list()) :: {:ok, map(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def fetch_rooms_values(%Token{token: token, lcode: lcode}, dfrom, dto, rooms \\ []) do
        with {:ok, [response], q, a} <- Query.send("fetch_rooms_values", [token, lcode, date_format(dfrom), date_format(dto), rooms]) do
          {:ok, response, q, a}
        end
      end
    end
  end
end
