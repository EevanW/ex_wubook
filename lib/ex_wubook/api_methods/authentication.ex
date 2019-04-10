defmodule ExWubook.Authentication do
  @moduledoc """
  API Methods for Authentication operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  alias ExWubook.Meta

  defmacro __using__(_) do
    quote do
      @doc """
      Get new token from Wubook
      """
      @spec acquire_token(String.t(), String.t(), String.t(), integer(), String.t()) ::
              {:ok, %Token{}, %Meta{}} | {:error, any(), %Meta{}}
      def acquire_token(user, password, provider_key, lcode, cc_password) do
        with {:ok, [token], meta} <- Query.send("acquire_token", [user, password, provider_key]) do
          {
            :ok,
            %Token{
              user: user,
              password: password,
              provider_key: provider_key,
              lcode: lcode,
              token: token,
              cc_password: cc_password
            },
            meta
          }
        end
      end

      @doc """
      Release token
      """
      @spec release_token(%Token{}) :: {:ok, nil, %Meta{}} | {:error, any(), %Meta{}}
      def release_token(%Token{token: token}) do
        with {:ok, _, meta} <- Query.send("release_token", [token]) do
          {:ok, nil, meta}
        end
      end

      @doc """
      Check token health
      """
      @spec is_token_valid(%Token{}) ::
              {:ok, %{is_valid: true, count_of_usage: integer}, %Meta{}}
              | {:error, any(), %Meta{}}
      def is_token_valid(%Token{token: token}) do
        with {:ok, [count_of_usage], meta} <- Query.send("is_token_valid", [token]) do
          {
            :ok,
            %{
              is_valid: true,
              count_of_usage: count_of_usage
            },
            meta
          }
        end
      end

      @doc """
      Get information about provider
      """
      @spec provider_info(%Token{}) :: {:ok, map, %Meta{}} | {:error, any(), %Meta{}}
      def provider_info(%Token{token: token}) do
        with {:ok, [provider_info], meta} <- Query.send("provider_info", [token]) do
          {:ok, provider_info, meta}
        end
      end
    end
  end
end
