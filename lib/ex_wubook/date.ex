defmodule ExWubook.Date do
  def date_format(%Date{} = date) do
    [date.day, date.month, date.year]
    |> Enum.map(&to_string/1)
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
    |> Enum.join("/")
  end

  def date_format(date), do: date
end
