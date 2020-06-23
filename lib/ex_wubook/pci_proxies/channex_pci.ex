defmodule ExWubook.PCIProxies.ChannexPCI do
  use HTTPClient

  @targetURI "https://wired.wubook.net/xrws/"

  @card_types %{
    1 => :visa,
    2 => :mastercard,
    4 => :discover,
    8 => :amex,
    16 => :en_route,
    32 => :jcb,
    64 => :diners,
    256 => :maestro
  }

  def fetch_card_info(
        %{
          user: user,
          password: password,
          provider_key: provider_key,
          lcode: lcode,
          cc_password: cc_password
        },
        booking_code,
        api_key
      ) do
    with {:ok, access_token} <- get_token(user, password, provider_key, api_key) do
      get_card_token(access_token, lcode, booking_code, cc_password, api_key)
    end
  end

  defp get_token(user, password, provider_key, api_key) do
    url = get_token_url(api_key)
    body = get_token_body_request(user, password, provider_key)

    with {:ok, body, _} <- send_request(url, body),
         {:ok, %{param: [_, token]}} <- XMLRPC.decode(body) do
      {:ok, token}
    end
  end

  defp get_token_url(api_key), do: get_url(@targetURI, api_key)
  defp get_card_token_url(api_key), do: get_url("#{@targetURI}&savecvv=true", api_key)

  defp get_url(url, api_key) do
    "#{pci_url()}?apikey=#{api_key}&method=post&profile=wubook&url=#{url}"
  end

  defp get_card_token(token, lcode, booking_code, password, api_key) do
    url = get_card_token_url(api_key)
    body = get_card_token_body(token, lcode, booking_code, password)

    with {:ok, body, headers} <- send_request(url, body),
         {:ok, %{param: [0, card_data]}} <- XMLRPC.decode(body) do
      {
        :ok,
        %{
          cardholder_name: card_data["cc_owner"],
          card_number: card_data["cc_number"],
          expiration_date: card_data["cc_expiring"],
          card_type: @card_types[card_data["cc_type"]],
          cvv: card_data["cc_cvv"],
          token: headers[:token]
        }
      }
    else
      {:ok, %XMLRPC.MethodResponse{param: [-17, "No CC for this reservation"]}} ->
        {:error, :no_cc_for_this_reservation}

      {:ok, %XMLRPC.MethodResponse{param: [-100, "Invalid Input"]}} ->
        {:error, :invalid_input}

      {_, error} ->
        {:error, error}

      error ->
        error
    end
  end

  defp get_token_body_request(user, password, provider_key) do
    """
    <?xml version="1.0"?>
    <methodCall>
      <methodName>acquire_token</methodName>
      <params>
        <param>
          <value>
            <string>#{user}</string>
          </value>
        </param>
        <param>
          <value>
            <string>#{password}</string>
          </value>
        </param>
        <param>
          <value>
            <string>#{provider_key}</string>
          </value>
        </param>
      </params>
    </methodCall>
    """
  end

  defp get_card_token_body(token, lcode, booking_code, password) do
    """
    <?xml version="1.0"?>
    <methodCall>
      <methodName>fetch_ccard</methodName>
      <params>
        <param><value><string>#{token}</string></value></param>
        <param><value><int>#{lcode}</int></value></param>
        <param><value><int>#{booking_code}</int></value></param>
        <param><value><string>#{password}</string></value></param>
      </params>
    </methodCall>
    """
  end

  defp send_request(url, body) do
    with {:ok, response} <- request(:post, url, body, [], []) do
      code = response.status

      meta =
        %{}
        |> add_cards_info(response.headers)
        |> finalize_meta(%{response: response.body, status_code: code})

      cond do
        code == 200 -> {:ok, response.body, meta}
        code == 404 -> {:error, :not_found, Map.update(meta, :errors, [], &[:not_found | &1])}
        code == 403 -> {:error, :forbidden, Map.update(meta, :errors, [], &[:forbidden | &1])}
        code >= 400 and code < 500 -> {:error, response.body, meta}
        true -> {:error, :server_error, meta}
      end
    else
      error ->
        {:error, :connection_error, Map.update(%{}, :errors, [], &[error | &1])}
    end
  end

  defp finalize_meta(meta, args) do
    meta
    |> Map.merge(args)
    |> Map.put(:finished_at, NaiveDateTime.utc_now())
  end

  defp add_cards_info(meta, headers) when is_list(headers) do
    token =
      headers
      |> Map.new()
      |> Map.get(pci_card_header(), nil)

    Map.put(meta, :token, token)
  end

  defp add_cards_info(meta, _headers), do: meta

  defp get_from(headers, key) do
    item = headers |> Enum.filter(fn {a, _} -> a == key end) |> List.first()

    if not is_nil(item) do
      elem(item, 1)
    else
      nil
    end
  end

  defp pci_url, do: Application.get_env(:ex_wubook, :pci_url)
  defp pci_card_header, do: Application.get_env(:ex_wubook, :pci_card_header)
end
