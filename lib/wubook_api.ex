defmodule WubookAPI do
  @moduledoc """
  Wubook API implementation
  """
  alias WubookAPI.Authentication
  alias WubookAPI.Error
  alias WubookAPI.Token

  @authentication_failed -1

  def new(args) do
    %{user: user, password: password, lcode: lcode, provider_key: provider_key} = Enum.into(args, %{})

    with {:ok, %{token: token}} <- Authentication.acquire_token(user, password, provider_key) do
      {:ok,
       %Token{
         user: user,
         password: password,
         provider_key: provider_key,
         lcode: lcode,
         token: token
       }}
    else
      {:error, error} ->
        {:error, error}
    end
  end

  def new!(args) do
    with {:ok, token} <- new(args) do
      token
    else
      {:error, _} ->
        raise Error, @authentication_failed
    end
  end
end
