defmodule ExWubook.Restrictions do
  @moduledoc """
  API Methods for Availability operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @doc """
      Add Restriction Plan
      """
      @spec rplan_add_rplan(%Token{}, String.t(), 0 | 1) :: {:ok, %{restriction_plan_id: integer()}} | {:error, any()}
      def rplan_add_rplan(%Token{token: token, lcode: lcode}, name, compact) do
        with {:ok, [id]} <- Query.send("rplan_add_rplan", [token, lcode, name, compact]) do
          {:ok, %{
            restriction_plan_id: id
          }}
        end
      end

      @doc """
      Get Restriction Plans
      """
      @spec rplan_rplans(%Token{}) :: {:ok, list()} | {:error, any()}
      def rplan_rplans(%Token{token: token, lcode: lcode}) do
        with {:ok, [plans]} <- Query.send("rplan_rplans", [token, lcode]) do
          {:ok, plans}
        end
      end

      @doc """
      Remove Restriction Plan
      """
      @spec rplan_del_rplan(%Token{}, integer()) :: {:ok, nil} | {:error, any()}
      def rplan_del_rplan(%Token{token: token, lcode: lcode}, rpid) do
        with {:ok, _} <- Query.send("rplan_del_rplan", [token, lcode, rpid]) do
          {:ok, nil}
        end
      end

      @doc """
      Rename Restriction Plan
      """
      @spec rplan_rename_rplan(%Token{}, integer(), String.t()) :: {:ok, nil} | {:error, any()}
      def rplan_rename_rplan(%Token{token: token, lcode: lcode}, rpid, name) do
        with {:ok, _} <- Query.send("rplan_rename_rplan", [token, lcode, rpid, name]) do
          {:ok, nil}
        end
      end

      @doc """
      Update Restriction Plan Rules
      """
      @spec rplan_update_rplan_rules(%Token{}, integer(), map()) :: {:ok, nil} | {:error, any()}
      def rplan_update_rplan_rules(%Token{token: token, lcode: lcode}, rpid, rules) do
        with {:ok, _} <- Query.send("rplan_update_rplan_rules", [token, lcode, rpid, rules]) do
          {:ok, nil}
        end
      end

      @doc """
      Update Restriction Plan Values
      """
      @spec rplan_update_rplan_values(%Token{}, integer(), Date.t(), map()) :: {:ok, nil} | {:error, any()}
      def rplan_update_rplan_values(%Token{token: token, lcode: lcode}, rpid, dfrom, values) do
        with {:ok, _} <- Query.send("rplan_update_rplan_values", [token, lcode, rpid, dfrom, values]) do
          {:ok, nil}
        end
      end

      @doc """
      Get Restriction Plan Values
      """
      @spec rplan_get_rplan_values(%Token{}, Date.t(), Date.t(), list() | nil) :: {:ok, map()} | {:error, any()}
      def rplan_get_rplan_values(%Token{token: token, lcode: lcode}, dfrom, dto, rpids \\ []) do
        with {:ok, [values]} <- Query.send("rplan_get_rplan_values", [token, lcode, dfrom, dto, rpids]) do
          {:ok, values}
        end
      end
    end
  end
end
