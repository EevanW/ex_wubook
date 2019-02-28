defmodule WubookAPI.Query do
  @moduledoc """
  API Query module
  """
  alias WubookAPI.Error

  @doc """
  Make query to API endpoint
  """
  @spec send(String.t(), list) :: {:ok, list} | {:error, any()}
  def send(method_name, params) do
    %XMLRPC.MethodCall{method_name: method_name, params: params}
    |> encode_request()
    |> send_query()
    |> decode_response()
    |> extract_data()
    |> validate_response()
  end

  @doc """
  Encode request from XMLRPC to plan XML String
  """
  @spec encode_request(XMLRPC.t()) ::
          {:ok, iodata()} | {:ok, String.t()} | {:error, {any(), String.t()}}
  def encode_request(payload) do
    XMLRPC.encode(payload)
  end

  @doc """
  Send query to target API endpoint
  """
  def send_query({:ok, request_body}) do
    HTTPoison.post(
      Application.get_env(:wubook_api, :api_endpoint),
      request_body
    )
  end

  def send_query({:error, _} = payload), do: payload

  @doc """
  Decode query result
  """
  def decode_response({:ok, %{status_code: 200, body: body}}) do
    XMLRPC.decode(body)
  end

  def decode_response({:ok, _}), do: {:error, :invalid_response_code}
  def decode_response({:error, _} = payload), do: payload

  @doc """
  Extract response arguments from XMLRPC structure
  """
  def extract_data({:ok, %XMLRPC.MethodResponse{param: [return_code | body]}}) do
    {:ok, [return_code, body]}
  end

  def extract_data({:ok, error}), do: {:error, error}
  def extract_data({:error, _} = payload), do: payload

  @doc """
  Validate response data
  """
  def validate_response({:ok, [0, body]}) do
    {:ok, body}
  end

  def validate_response({:ok, [error_code, _body]}), do: {:error, Error.exception(error_code)}
  def validate_response({:ok, _}), do: {:error, :undefined_error}
  def validate_response({:error, _} = payload), do: payload
end
