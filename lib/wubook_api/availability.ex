defmodule WubookAPI.Availability do
  @moduledoc """
  API Methods for Availability operations
  """
  alias WubookAPI.Token
  alias WubookAPI.Query

  @doc """
  Update Availability Range
  """
  @spec update_avail(%Token{}, Date.t(), list()) :: {:ok, nil} | {:error, any()}
  def update_avail(%Token{token: token, lcode: lcode}, dfrom, rooms) do
    # rooms: [%{id: 362671, days: [%{avail: 1}]}]
    with {:ok, _} <- Query.send("update_avail", [token, lcode, dfrom, rooms]) do
      {:ok, nil}
    end
  end

  @doc """
  Update Sparse Availability
  """
  @spec update_sparse_avail(%Token{}, list()) :: {:ok, nil} | {:error, any()}
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
    with {:ok, _} <- Query.send("update_sparse_avail", [token, lcode, rooms]) do
      {:ok, nil}
    end
  end

  @doc """
  Fetch room values
  """
  @spec fetch_rooms_values(%Token{}, Date.t(), Date.t(), list()) :: {:ok, map()} | {:error, any()}
  def fetch_rooms_values(%Token{token: token, lcode: lcode}, dfrom, dto, rooms \\ []) do
    with {:ok, [response]} <- Query.send("fetch_rooms_values", [token, lcode, dfrom, dto, rooms]) do
      {:ok, response}
    end
  end
end
