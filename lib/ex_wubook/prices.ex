defmodule ExWubook.Prices do
  @moduledoc """
  API Methods for Availability operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @doc """
      Add Pricing Plan
      """
      @spec add_pricing_plan(%Token{}, String.t(), 0 | 1) :: {:ok, map(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def add_pricing_plan(%Token{token: token, lcode: lcode}, name, daily \\ 1) do
        with {:ok, [id], q, a} <- Query.send("add_pricing_plan", [token, lcode, name, daily]) do
          {:ok, %{pricing_plan_id: id}, q, a}
        end
      end

      @doc """
      Add Virtual Pricing Plan
      """
      @spec add_vplan(%Token{}, String.t(), integer(), -2 | -1 | 1 | 2, number()) :: {:ok, map(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def add_vplan(%Token{token: token, lcode: lcode}, name, pid, dtype, value) do
        with {:ok, [id], q, a} <- Query.send("add_vplan", [token, lcode, name, pid, dtype, value]) do
          {:ok, %{pricing_plan_id: id}, q, a}
        end
      end

      @doc """
      Remove Pricing plan
      """
      @spec del_plan(%Token{}, integer()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def del_plan(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, _, q, a} <- Query.send("del_plan", [token, lcode, pid]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update Pricing plan name
      """
      @spec update_plan_name(%Token{}, integer(), String.t()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_plan_name(%Token{token: token, lcode: lcode}, pid, name) do
        with {:ok, _, q, a} <- Query.send("update_plan_name", [token, lcode, pid, name]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Get Pricing Plans
      """
      @spec get_pricing_plans(%Token{}) :: {:ok, list(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def get_pricing_plans(%Token{token: token, lcode: lcode}) do
        with {:ok, [plans], q, a} <- Query.send("get_pricing_plans", [token, lcode]) do
          {:ok, plans, q, a}
        end
      end

      @doc """
      Update Pricing plan default values
      """
      @spec update_plan_rack(%Token{}, integer(), map()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_plan_rack(%Token{token: token, lcode: lcode}, pid, rack) do
        with {:ok, _, q, a} <- Query.send("update_plan_rack", [token, lcode, pid, rack]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Modify Virtual Pricing plans
      """
      @spec mod_vplans(%Token{}, list()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def mod_vplans(%Token{token: token, lcode: lcode}, plans) do
        with {:ok, _, q, a} <- Query.send("mod_vplans", [token, lcode, plans]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update Pricing plan prices
      """
      @spec update_plan_prices(%Token{}, integer(), Date.t(), map()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_plan_prices(%Token{token: token, lcode: lcode}, pid, dfrom, prices) do
        with {:ok, _, q, a} <- Query.send("update_plan_prices", [token, lcode, pid, date_format(dfrom), prices]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Fetch plan prices
      """
      @spec fetch_plan_prices(%Token{}, integer(), Date.t(), Date.t(), list()) :: {:ok, map(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def fetch_plan_prices(%Token{token: token, lcode: lcode}, pid, dfrom, dto, rooms \\ []) do
        with {:ok, [prices], q, a} <- Query.send("fetch_plan_prices", [token, lcode, pid, date_format(dfrom), date_format(dto), rooms]) do
          {:ok, prices, q, a}
        end
      end

      @doc """
      Convert to daily plan
      """
      @spec convert_to_daily_plan(%Token{}, integer()) :: {:ok, any(), String.t(), String.t()} :: {:error, any(), String.t(), String.t()}
      def convert_to_daily_plan(%Token{token: token, lcode: lcode}, pid) do
        with {:ok, _, q, a} <- Query.send("convert_to_daily_plan", [token, lcode, pid]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update plan periods
      """
      @spec update_plan_periods(%Token{}, integer(), list()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def update_plan_periods(%Token{token: token, lcode: lcode}, pid, periods) do
        with {:ok, _, q, a} <- Query.send("update_plan_periods", [token, lcode, pid, periods]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Remove periods
      """
      @spec delete_periods(%Token{}, integer(), list()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def delete_periods(%Token{token: token, lcode: lcode}, pid, periods) do
        with {:ok, _, q, a} <- Query.send("delete_periods", [token, lcode, pid, periods]) do
          {:ok, nil, q, a}
        end
      end
    end
  end
end
