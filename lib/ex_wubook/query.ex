defmodule ExWubook.Query do
  @moduledoc """
  API Query module
  """
  alias ExWubook.Error
  alias ExWubook.Meta

  @api_endpoint "https://wired.wubook.net/xrws/"

  @doc """
  Make query to API endpoint
  """
  @spec send(String.t(), list) :: {:ok, list, %Meta{}} | {:error, any(), %Meta{}}
  def send(method_name, params) do
    %{
      request: %XMLRPC.MethodCall{method_name: method_name, params: params},
      method: method_name,
      started_at: DateTime.utc_now(),
      success: true,
      errors: []
    }
    |> encode_request()
    |> send_query()
    |> decode_response()
    |> extract_data()
    |> validate_response()
    |> format_answer()
  end

  @doc """
  Encode request from XMLRPC to plan XML String
  """
  def encode_request(%{request: request} = payload) do
    with {:ok, encoded_request} <- XMLRPC.encode(request) do
      payload
      |> Map.put(:encoded_request, encoded_request)
    else
      {:error, error} ->
        payload
        |> Map.put(:success, false)
        |> Map.put(:error, error)
    end
  end

  @doc """
  Send query to target API endpoint
  """
  def send_query(%{success: true, encoded_request: encoded_request} = payload) do
    with {:ok, response} <- HTTPoison.post(@api_endpoint, encoded_request) do
      payload
      |> Map.put(:response, response)
      |> Map.put(:finished_at, DateTime.utc_now())
    else
      {:error, error} ->
        payload
        |> Map.put(:success, false)
        |> Map.put(:error, error)
    end
  end

  def send_query(payload), do: payload

  @doc """
  Decode query result
  """
  def decode_response(%{success: true, response: %{status_code: 200, body: body}} = payload) do
    with {:ok, decoded_response} <- XMLRPC.decode(body) do
      payload
      |> Map.put(:decoded_response, decoded_response)
    else
      {:error, error} ->
        payload
        |> Map.put(:success, false)
        |> Map.put(:error, error)
    end
  end

  def decode_response(%{success: true} = payload) do
    payload
    |> Map.put(:success, false)
    |> Map.put(:error, :invalid_response_code)
  end

  def decode_response(payload), do: payload

  @doc """
  Extract response arguments from XMLRPC structure
  """
  def extract_data(
        %{success: true, decoded_response: %XMLRPC.MethodResponse{param: [return_code | body]}} =
          payload
      )
      when is_number(return_code) do
    payload
    |> Map.put(:raw_answer, [return_code, body])
  end

  def extract_data(
        %{success: true, decoded_response: %XMLRPC.MethodResponse{param: body}} = payload
      ) do
    payload
    |> Map.put(:raw_answer, [0, body])
  end

  def extract_data(payload), do: payload

  @doc """
  Validate response data
  """
  def validate_response(%{success: true, raw_answer: [0, body]} = payload) do
    Map.put(payload, :answer, {:ok, body})
  end

  def validate_response(%{success: true, raw_answer: [error_code, _body]} = payload) do
    Map.put(payload, :answer, {:error, Error.exception(error_code)})
  end

  def validate_response(%{success: true, raw_answer: _} = payload) do
    Map.put(payload, :answer, {:error, :undefined_error})
  end

  def validate_response(%{success: false, error: error} = payload) do
    Map.put(payload, :answer, {:error, error})
  end

  @doc """
  Format answer
  """
  def format_answer(%{answer: {code, data}} = payload) do
    raw_request = Map.get(payload, :encoded_request)

    raw_response =
      case Map.fetch(payload, :response) do
        :error -> nil
        {:ok, %{body: body}} -> body
        _ -> nil
      end

    {
      code,
      data,
      %Meta{
        request: raw_request,
        response: raw_response,
        method: Map.get(payload, :method),
        started_at: Map.get(payload, :started_at),
        finished_at: Map.get(payload, :finished_at) || DateTime.utc_now()
      }
    }
  end
end
