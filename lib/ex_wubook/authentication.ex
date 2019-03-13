defmodule ExWubook.Authentication do
  @moduledoc """
  API Methods for Authentication operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @doc """
      Get new token from Wubook
      """
      @spec acquire_token(String.t(), String.t(), String.t(), integer()) ::
              {:ok, %Token{}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def acquire_token(user, password, provider_key, lcode) do
        with {:ok, [token], q, a} <- Query.send("acquire_token", [user, password, provider_key]) do
          {
            :ok,
            %Token{
              user: user,
              password: password,
              provider_key: provider_key,
              lcode: lcode,
              token: token
            },
            q,
            a
          }
        end
      end

      @doc """
      Release token
      """
      @spec release_token(%Token{}) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def release_token(%Token{token: token}) do
        with {:ok, _, q, a} <- Query.send("release_token", [token]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Check token health
      """
      @spec is_token_valid(%Token{}) ::
              {:ok, %{is_valid: true, count_of_usage: integer}, String.t(), String.t()}
              | {:error, any(), String.t(), String.t()}
      def is_token_valid(%Token{token: token}) do
        with {:ok, [count_of_usage], q, a} <- Query.send("is_token_valid", [token]) do
          {
            :ok,
            %{
              is_valid: true,
              count_of_usage: count_of_usage
            },
            q,
            a
          }
        end
      end

      @doc """
      Get information about provider
      """
      @spec provider_info(%Token{}) :: {:ok, map, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def provider_info(%Token{token: token}) do
        with {:ok, [provider_info], q, a} <- Query.send("provider_info", [token]) do
          {:ok, provider_info, q, a}
        end
      end
    end
  end
end
