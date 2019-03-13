defmodule ExWubook.Corporate do
  @moduledoc """
  API Methods for Corporate operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @spec corporate_fetch_accounts(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_fetch_accounts(%Token{token: token}, acode \\ nil) do
        with {:ok, [response], q, a} <- Query.send("corporate_fetch_accounts", [token, acode]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_get_providers_info(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_get_providers_info(%Token{token: token}, acodes \\ nil) do
        with {:ok, [response], q, a} <- Query.send("corporate_get_providers_info", [token, acodes]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_fetch_channels(%Token{}) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_fetch_channels(%Token{token: token, lcode: lcode}) do
        with {:ok, [response], q, a} <- Query.send("corporate_fetch_channels", [token, lcode]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_get_channels(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_get_channels(%Token{token: token}, filters) do
        with {:ok, [response], q, a} <- Query.send("corporate_get_channels", [token, filters]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_fetchable_properties(%Token{}) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_fetchable_properties(%Token{token: token}) do
        with {:ok, [response], q, a} <- Query.send("corporate_fetchable_properties", [token]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_new_property(%Token{}, any(), any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_new_property(%Token{token: token}, lodg, woodoo_only, acode) do
        with {:ok, [response], q, a} <- Query.send("corporate_new_property", [token, lodg, woodoo_only, acode]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_new_account_and_property(%Token{}, any(), any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_new_account_and_property(%Token{token: token}, lodg, woodoo_only, account) do
        with {:ok, [response], q, a} <- Query.send("corporate_new_account_and_property", [token, lodg, woodoo_only, account]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_renew_booking(%Token{}, any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_renew_booking(%Token{token: token, lcode: lcode}, months, pretend \\ 1) do
        with {:ok, [response], q, a} <- Query.send("corporate_renew_booking", [token, lcode, months, pretend]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_renew_channels(%Token{}, any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_renew_channels(%Token{token: token, lcode: lcode}, channels, pretend \\ 1) do
        with {:ok, [response], q, a} <- Query.send("corporate_renew_channels", [token, lcode, channels, pretend]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_set_autorenew_wb(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_set_autorenew_wb(%Token{token: token, lcode: lcode}, set_autorenew) do
        with {:ok, [response], q, a} <- Query.send("corporate_set_autorenew_wb", [token, lcode, set_autorenew]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_set_autorenew_zak(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_set_autorenew_zak(%Token{token: token, lcode: lcode}, set_autorenew) do
        with {:ok, [response], q, a} <- Query.send("corporate_set_autorenew_zak", [token, lcode, set_autorenew]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_set_autorenew_wo(%Token{}, any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_set_autorenew_wo(%Token{token: token, lcode: lcode}, lchans, set_autorenew) do
        with {:ok, [response], q, a} <- Query.send("corporate_set_autorenew_wo", [token, lcode, lchans, set_autorenew]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_balance_transactions(%Token{}) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_balance_transactions(%Token{token: token}) do
        with {:ok, [response], q, a} <- Query.send("corporate_balance_transactions", [token]) do
          {:ok, response, q, a}
        end
      end

      @spec corporate_balance_details(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def corporate_balance_details(%Token{token: token}, transaction_id) do
        with {:ok, [response], q, a} <- Query.send("corporate_balance_details", [token, transaction_id]) do
          {:ok, response, q, a}
        end
      end
    end
  end
end
