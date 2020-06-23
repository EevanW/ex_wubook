defmodule ExWubook.CardInfo do
  @provider ExWubook.PCIProxies.ChannexPCI

  def fetch_card_info(token, booking_code, api_key, provider \\ @provider) do
    provider.fetch_card_info(token, booking_code, api_key)
  end
end
