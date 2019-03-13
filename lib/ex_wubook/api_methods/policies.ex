defmodule ExWubook.Policies do
  @moduledoc """
  API Methods for Policy operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  alias ExWubook.Meta
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @spec fetch_policies(%Token{}, 0 | 1 | nil) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_policies(%Token{token: token, lcode: lcode}, ancillary \\ 0) do
        with {:ok, [response], meta} <- Query.send("fetch_policies", [token, lcode, ancillary]) do
          {:ok, response, meta}
        end
      end

      @spec new_policy(%Token{}, map()) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def new_policy(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [response], meta} <-
          Query.send("new_policy", [
            token,
            lcode,
            # Required arguments
            args[:name] || nil,
            args[:pshow] || nil,
            args[:ptype] || nil,
            # Optional arguments
            args[:value] || nil,
            args[:days] || nil,
            args[:descrs] || nil
          ]) do
          {:ok, response, meta}
        end
      end

      @spec mod_policy(%Token{}, integer(), map()) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def mod_policy(%Token{token: token, lcode: lcode}, pid, args) do
        with {:ok, [response], meta} <-
          Query.send("mod_policy", [
            token,
            lcode,
            pid,
            # Required arguments
            args[:name] || nil,
            args[:pshow] || nil,
            args[:ptype] || nil,
            # Optional arguments
            args[:value] || nil,
            args[:days] || nil,
            args[:descrs] || nil
          ]) do
          {:ok, response, meta}
        end
      end

      @spec del_policy(%Token{}, integer()) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def del_policy(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, [response], meta} <- Query.send("del_policy", [token, lcode, pid]) do
          {:ok, response, meta}
        end
      end

      @spec fetch_policy_calendar(%Token{}, Date.t(), Date.t()) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def fetch_policy_calendar(%Token{token: token, lcode: lcode}, dfrom, dto) do
        with {:ok, [response], meta} <- Query.send("fetch_policy_calendar", [token, lcode, date_format(dfrom), date_format(dto)]) do
          {:ok, response, meta}
        end
      end

      @spec set_policy_calendar(%Token{}, integer(), Date.t(), Date.t()) :: {:ok, any(), %Meta{}} | {:error, any(), %Meta{}}
      def set_policy_calendar(%Token{token: token, lcode: lcode}, pid, dfrom, dto) do
        with {:ok, [response], meta} <- Query.send("set_policy_calendar", [token, lcode, pid, date_format(dfrom), date_format(dto)]) do
          {:ok, response, meta}
        end
      end
    end
  end
end
