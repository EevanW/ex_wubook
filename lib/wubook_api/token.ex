defmodule WubookAPI.Token do
  defstruct user: nil,
            password: nil,
            provider_key: nil,
            lcode: nil,
            token: nil
end
