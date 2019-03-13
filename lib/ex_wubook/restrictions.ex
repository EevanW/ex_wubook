defmodule ExWubook.Restrictions do
  @moduledoc """
  API Methods for Availability operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @doc """
      Add Restriction Plan
      """
      @spec rplan_add_rplan(%Token{}, String.t(), 0 | 1) :: {:ok, %{restriction_plan_id: integer()}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_add_rplan(%Token{token: token, lcode: lcode}, name, compact) do
        with {:ok, [id], q, a} <- Query.send("rplan_add_rplan", [token, lcode, name, compact]) do
          {:ok, %{
            restriction_plan_id: id
          }, q, a}
        end
      end

      @doc """
      Get Restriction Plans
      """
      @spec rplan_rplans(%Token{}) :: {:ok, list(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_rplans(%Token{token: token, lcode: lcode}) do
        with {:ok, [plans], q, a} <- Query.send("rplan_rplans", [token, lcode]) do
          {:ok, plans, q, a}
        end
      end

      @doc """
      Remove Restriction Plan
      """
      @spec rplan_del_rplan(%Token{}, integer()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_del_rplan(%Token{token: token, lcode: lcode}, rpid) do
        with {:ok, _, q, a} <- Query.send("rplan_del_rplan", [token, lcode, rpid]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Rename Restriction Plan
      """
      @spec rplan_rename_rplan(%Token{}, integer(), String.t()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_rename_rplan(%Token{token: token, lcode: lcode}, rpid, name) do
        with {:ok, _, q, a} <- Query.send("rplan_rename_rplan", [token, lcode, rpid, name]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update Restriction Plan Rules
      """
      @spec rplan_update_rplan_rules(%Token{}, integer(), map()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_update_rplan_rules(%Token{token: token, lcode: lcode}, rpid, rules) do
        with {:ok, _, q, a} <- Query.send("rplan_update_rplan_rules", [token, lcode, rpid, rules]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Update Restriction Plan Values
      """
      @spec rplan_update_rplan_values(%Token{}, integer(), Date.t(), map()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_update_rplan_values(%Token{token: token, lcode: lcode}, rpid, dfrom, values) do
        with {:ok, _, q, a} <- Query.send("rplan_update_rplan_values", [token, lcode, rpid, date_format(dfrom), values]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Get Restriction Plan Values
      """
      @spec rplan_get_rplan_values(%Token{}, Date.t(), Date.t(), list() | nil) :: {:ok, map(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def rplan_get_rplan_values(%Token{token: token, lcode: lcode}, dfrom, dto, rpids \\ []) do
        with {:ok, [values], q, a} <- Query.send("rplan_get_rplan_values", [token, lcode, date_format(dfrom), date_format(dto), rpids]) do
          {:ok, values, q, a}
        end
      end
    end
  end
end
