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
              {:ok, %Token{}} | {:error, any()}
      def acquire_token(user, password, provider_key, lcode) do
        with {:ok, [token]} <- Query.send("acquire_token", [user, password, provider_key]) do
          {:ok,
          %Token{
            user: user,
            password: password,
            provider_key: provider_key,
            lcode: lcode,
            token: token
          }}
        end
      end

      @doc """
      Release token
      """
      @spec release_token(%Token{}) :: {:ok, nil} | {:error, any()}
      def release_token(%Token{token: token}) do
        with {:ok, _} <- Query.send("release_token", [token]) do
          {:ok, nil}
        end
      end

      @doc """
      Check token health
      """
      @spec is_token_valid(%Token{}) ::
              {:ok, %{is_valid: true, count_of_usage: integer}} | {:error, any()}
      def is_token_valid(%Token{token: token}) do
        with {:ok, [count_of_usage]} <- Query.send("is_token_valid", [token]) do
          {:ok,
          %{
            is_valid: true,
            count_of_usage: count_of_usage
          }}
        end
      end

      @doc """
      Get information about provider
      """
      @spec provider_info(%Token{}) :: {:ok, map} | {:error, any()}
      def provider_info(%Token{token: token}) do
        with {:ok, [provider_info]} <- Query.send("provider_info", [token]) do
          {:ok, provider_info}
        end
      end
    end
  end
end
