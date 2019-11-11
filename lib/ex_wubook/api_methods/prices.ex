defmodule ExWubook.Prices do
  @moduledoc """
  API Methods for Availability operations
  """
  alias ExWubook.Meta
  alias ExWubook.Token
  alias ExWubook.Query
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @doc """
      Add Pricing Plan
      """
      @type meta :: Meta.t()
      @type token :: Token.t()
      @type error_response :: {:error, any(), meta()}
      @type any_response :: {:ok, any(), meta()} | error_response()
      @type map_response :: {:ok, map(), meta()} | error_response()
      @type list_response :: {:ok, list(), meta()} | error_response()
      @type nil_response :: {:ok, nil, meta()} | error_response()

      @spec add_pricing_plan(token(), String.t(), 0 | 1) :: map_response()

      def add_pricing_plan(%Token{token: token, lcode: lcode}, name, daily \\ 1) do
        with {:ok, [id], meta} <- Query.send("add_pricing_plan", [token, lcode, name, daily]) do
          {:ok, %{pricing_plan_id: id}, meta}
        end
      end

      @doc """
      Add Virtual Pricing Plan
      """
      @spec add_vplan(token(), String.t(), integer(), -2 | -1 | 1 | 2, number()) ::
              map_response()
      def add_vplan(%Token{token: token, lcode: lcode}, name, pid, dtype, value) do
        with {:ok, [id], meta} <- Query.send("add_vplan", [token, lcode, name, pid, dtype, value]) do
          {:ok, %{pricing_plan_id: id}, meta}
        end
      end

      @doc """
      Remove Pricing plan
      """
      @spec del_plan(token(), integer()) :: nil_response()
      def del_plan(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, _, meta} <- Query.send("del_plan", [token, lcode, pid]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Update Pricing plan name
      """
      @spec update_plan_name(token(), integer(), String.t()) :: nil_response()
      def update_plan_name(%Token{token: token, lcode: lcode}, pid, name) do
        with {:ok, _, meta} <- Query.send("update_plan_name", [token, lcode, pid, name]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Get Pricing Plans
      """
      @spec get_pricing_plans(token()) :: list_response()
      def get_pricing_plans(%Token{token: token, lcode: lcode}) do
        with {:ok, [plans], meta} <- Query.send("get_pricing_plans", [token, lcode]) do
          {:ok, plans, meta}
        end
      end

      @doc """
      Update Pricing plan default values
      """
      @spec update_plan_rack(token(), integer(), map()) :: nil_response()
      def update_plan_rack(%Token{token: token, lcode: lcode}, pid, rack) do
        with {:ok, _, meta} <- Query.send("update_plan_rack", [token, lcode, pid, rack]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Modify Virtual Pricing plans
      """
      @spec mod_vplans(token(), list()) :: nil_response()
      def mod_vplans(%Token{token: token, lcode: lcode}, plans) do
        with {:ok, _, meta} <- Query.send("mod_vplans", [token, lcode, plans]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Update Pricing plan prices
      """
      @spec update_plan_prices(token(), integer(), Date.t(), map()) :: nil_response()
      def update_plan_prices(%Token{token: token, lcode: lcode}, pid, dfrom, prices) do
        with {:ok, _, meta} <-
               Query.send("update_plan_prices", [token, lcode, pid, date_format(dfrom), prices]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Fetch plan prices
      """
      @spec fetch_plan_prices(token(), integer(), Date.t(), Date.t(), list()) :: map_response()
      def fetch_plan_prices(%Token{token: token, lcode: lcode}, pid, dfrom, dto, rooms \\ []) do
        with {:ok, [prices], meta} <-
               Query.send("fetch_plan_prices", [
                 token,
                 lcode,
                 pid,
                 date_format(dfrom),
                 date_format(dto),
                 rooms
               ]) do
          {:ok, prices, meta}
        end
      end

      @doc """
      Convert to daily plan
      """
      @spec convert_to_daily_plan(token(), integer()) :: any_response()
      def convert_to_daily_plan(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, _, meta} <- Query.send("convert_to_daily_plan", [token, lcode, pid]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Update plan periods
      """
      @spec update_plan_periods(token(), integer(), list()) :: any_response()
      def update_plan_periods(%Token{token: token, lcode: lcode}, pid, periods) do
        with {:ok, _, meta} <- Query.send("update_plan_periods", [token, lcode, pid, periods]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Remove periods
      """
      @spec delete_periods(token(), integer(), list()) :: nil_response()
      def delete_periods(%Token{token: token, lcode: lcode}, pid, periods) do
        with {:ok, _, meta} <- Query.send("delete_periods", [token, lcode, pid, periods]) do
          {:ok, nil, meta}
        end
      end
    end
  end
end
