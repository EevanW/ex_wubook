defmodule ExWubook.Token do
  defstruct user: nil,
            password: nil,
            provider_key: nil,
            lcode: nil,
            token: nil,
            cc_password: nil

  @type t :: %__MODULE__{
          user: String.t(),
          password: String.t(),
          provider_key: String.t(),
          lcode: String.t(),
          token: String.t(),
          cc_password: String.t()
        }
end
