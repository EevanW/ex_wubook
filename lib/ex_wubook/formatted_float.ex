defmodule ExWubook.FormattedFloat do

  def convert(float, exponent) do
    XMLRPC.FormattedFloat.new({float, "~.#{exponent}f"})
  end
end
