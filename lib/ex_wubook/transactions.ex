defmodule ExWubook.Transactions do
  @moduledoc """
  API Methods for Transactions operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @spec get_balance(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def get_balance(%Token{token: token, lcode: lcode}, status) do
        with {:ok, [response], q, a} <- Query.send("get_balance", [token, lcode, status]) do
          {:ok, response, q, a}
        end
      end

      @spec get_crp_balance(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def get_crp_balance(%Token{token: token}, status) do
        with {:ok, [response], q, a} <- Query.send("get_crp_balance", [token, status]) do
          {:ok, response, q, a}
        end
      end

      @spec pay_balance(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def pay_balance(%Token{token: token}, balance_ids) do
        with {:ok, [response], q, a} <- Query.send("pay_balance", [token, balance_ids]) do
          {:ok, response, q, a}
        end
      end

      @spec detach_balance(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def detach_balance(%Token{token: token}, balance_ids) do
        with {:ok, [response], q, a} <- Query.send("detach_balance", [token, balance_ids]) do
          {:ok, response, q, a}
        end
      end

      @spec pay_balance_with_credit(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def pay_balance_with_credit(%Token{token: token, lcode: lcode}, balance_ids) do
        with {:ok, [response], q, a} <- Query.send("pay_balance_with_credit", [token, lcode, balance_ids]) do
          {:ok, response, q, a}
        end
      end

      @spec balance_transactions(%Token{}) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def balance_transactions(%Token{token: token}) do
        with {:ok, [response], q, a} <- Query.send("balance_transactions", [token]) do
          {:ok, response, q, a}
        end
      end

      @spec balance_details(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def balance_details(%Token{token: token}, transaction_id) do
        with {:ok, [response], q, a} <- Query.send("balance_details", [token, transaction_id]) do
          {:ok, response, q, a}
        end
      end
    end
  end
end
