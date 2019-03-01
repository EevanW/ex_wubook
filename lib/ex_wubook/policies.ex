defmodule ExWubook.Policies do
  @moduledoc """
  API Methods for Policy operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @spec fetch_policies(%Token{}, 0 | 1 | nil) :: {:ok, any()} | {:error, any()}
      def fetch_policies(%Token{token: token, lcode: lcode}, ancillary \\ 0) do
        with {:ok, [response]} <- Query.send("fetch_policies", [token, lcode, ancillary]) do
          {:ok, response}
        end
      end

      @spec new_policy(%Token{}, map()) :: {:ok, any()} | {:error, any()}
      def new_policy(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [response]} <-
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
          {:ok, response}
        end
      end

      @spec mod_policy(%Token{}, integer(), map()) :: {:ok, any()} | {:error, any()}
      def mod_policy(%Token{token: token, lcode: lcode}, pid, args) do
        with {:ok, [response]} <-
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
          {:ok, response}
        end
      end

      @spec del_policy(%Token{}, integer()) :: {:ok, any()} | {:error, any()}
      def del_policy(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, [response]} <- Query.send("del_policy", [token, lcode, pid]) do
          {:ok, response}
        end
      end

      @spec fetch_policy_calendar(%Token{}, Date.t(), Date.t()) :: {:ok, any()} | {:error, any()}
      def fetch_policy_calendar(%Token{token: token, lcode: lcode}, dfrom, dto) do
        with {:ok, [response]} <- Query.send("fetch_policy_calendar", [token, lcode, dfrom, dto]) do
          {:ok, response}
        end
      end

      @spec set_policy_calendar(%Token{}, integer(), Date.t(), Date.t()) :: {:ok, any()} | {:error, any()}
      def set_policy_calendar(%Token{token: token, lcode: lcode}, pid, dfrom, dto) do
        with {:ok, [response]} <- Query.send("set_policy_calendar", [token, lcode, pid, dfrom, dto]) do
          {:ok, response}
        end
      end
    end
  end
end
