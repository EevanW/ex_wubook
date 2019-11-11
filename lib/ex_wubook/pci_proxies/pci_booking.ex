defmodule ExWubook.PCIProxies.PCIBooking do
  @api_endpoint "https://service.pcibooking.net/api"
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

  def fetch_card_info(token, booking_code, api_key) do
    with %{
           user: user,
           password: password,
           provider_key: provider_key,
           lcode: lcode,
           cc_password: cc_password
         } <- token,
         {:ok, access_token} <- get_token(user, password, provider_key, api_key),
         response <- get_card_token(access_token, lcode, booking_code, cc_password, api_key) do
      response
    end
  end

  defp get_token(user, password, provider_key, api_key) do
    with {:ok, temp_session} <- start_temporary_session(api_key),
         url <- get_token_url(temp_session),
         body <- get_token_body_request(user, password, provider_key),
         {:ok, body, _} <- send_request(url, body, api_key),
         {:ok, %{param: [_, token]}} <- XMLRPC.decode(body) do
      {:ok, token}
    else
      error -> error
    end
  end

  defp get_card_token(token, lcode, booking_code, password, api_key, without_cvv \\ false) do
    with {:ok, temp_session} <- start_temporary_session(api_key),
         url <- get_card_token_url(temp_session, without_cvv),
         body <- get_card_token_body(token, lcode, booking_code, password),
         {:ok, body, headers} <- send_request(url, body, api_key),
         {:ok, %{param: [0, card_data]}} <- XMLRPC.decode(body) do
      if get_from(headers, "X-pciBooking-Tokenization-Errors") == "Cvv must be 3 or 4 digits" do
        get_card_token(token, lcode, booking_code, password, api_key, true)
      else
        {
          :ok,
          %{
            cardholder_name: card_data["cc_owner"],
            card_number: card_data["cc_number"],
            expiration_date: card_data["cc_expiring"],
            card_type: @card_types[card_data["cc_type"]],
            cvv: card_data["cc_cvv"],
            token: get_from(headers, "X-WUBOOKFETCHCC"),
            errors: get_from(headers, "X-pciBooking-Tokenization-Errors"),
            warnings: get_from(headers, "X-pciBooking-Tokenization-Warnings")
          }
        }
      end
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

  defp get_token_url(temp_session) do
    get_url("/payments/paycard/capture",
      sessionToken: temp_session,
      profileName: "WubookWO",
      targetURI: "https://wired.wubook.net/xrws/"
    )
  end

  defp get_token_body_request(user, password, provider_key) do
    """
    <?xml version="1.0" ?>
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

  defp get_card_token_url(temp_session, without_cvv) do
    get_url("/payments/paycard/capture",
      sessionToken: temp_session,
      profileName: if(without_cvv, do: "WubookWOCVV", else: "Wubook"),
      targetURI: "https://wired.wubook.net/xrws/",
      saveCVV: true
    )
  end

  defp get_card_token_body(token, lcode, booking_code, password) do
    """
    <?xml version="1.0" ?>
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

  defp start_temporary_session(api_key) do
    with {:ok, body, _} <- send_request("/payments/paycard/tempsession", "", api_key) do
      {:ok, String.replace(body, "\"", "")}
    else
      error -> error
    end
  end

  defp get_url(url, arguments) do
    arguments =
      arguments
      |> Enum.reduce(
        [],
        fn {key, value}, acc ->
          acc ++ ["#{key}=#{value}"]
        end
      )
      |> Enum.join("&")

    "#{url}?#{arguments}"
  end

  defp send_request(url, body, api_key) do
    with {:ok, %{body: body, headers: headers, status_code: 200}} <-
           HTTPoison.post("#{@api_endpoint}#{url}", String.trim(body), headers(api_key)) do
      {
        :ok,
        body,
        headers
      }
    else
      {:ok, %{status_code: 401}} ->
        {:error, :wrong_api_key}

      {:ok, response} ->
        {:error, response}

      {:error, error} ->
        {:error, error}
    end
  end

  defp headers(api_key) do
    [
      {"Authorization", "APIKEY #{api_key}"},
      {"Cache-Control", "no-cache"}
    ]
  end

  defp get_from(headers, key) do
    item = headers |> Enum.filter(fn {a, _} -> a == key end) |> List.first()

    if not is_nil(item) do
      elem(item, 1)
    else
      nil
    end
  end
end
