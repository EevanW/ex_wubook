defmodule ExWubook.Extras do
  @moduledoc """
  API Methods for Extras operations
  """
  alias ExWubook.Token
  alias ExWubook.Query
  import ExWubook.Date, only: [date_format: 1]

  defmacro __using__(_) do
    quote do
      @spec fetch_opportunities(%Token{}, any(), any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def fetch_opportunities(%Token{token: token, lcode: lcode}, dfrom \\ nil, dto \\ nil, ancillary \\ 0) do
        with {:ok, [response], q, a} <- Query.send("fetch_opportunities", [token, lcode, date_format(dfrom), date_format(dto), ancillary]) do
          {:ok, response, q, a}
        end
      end

      @spec new_opportunity(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def new_opportunity(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [response], q, a} <-
          Query.send("new_opportunity", [
            token,
            lcode,
            # Required arguments
            args[:name] || nil,
            args[:active] || nil,
            args[:perday] || nil,
            args[:extra] || nil,
            args[:price] || nil,
            args[:how] || nil,
            (if args[:dfrom], do: date_format(args[:dfrom]), else: nil),
            # Optional arguments
            args[:wdays] || nil,
            args[:rooms] || nil,
            args[:names] || nil,
            args[:descrs] || nil
          ]) do
          {:ok, response, q, a}
        end
      end

      @spec mod_opportunity(%Token{}, any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def mod_opportunity(%Token{token: token, lcode: lcode}, oid, args) do
        with {:ok, [response], q, a} <-
          Query.send("new_opportunity", [
            token,
            lcode,
            oid,
            # Optional arguments
            args[:name] || nil,
            args[:active] || nil,
            args[:perday] || nil,
            args[:extra] || nil,
            args[:price] || nil,
            args[:how] || nil,
            (if args[:dfrom], do: date_format(args[:dfrom]), else: nil),
            args[:wdays] || nil,
            args[:rooms] || nil,
            args[:names] || nil,
            args[:descrs] || nil
          ]) do
          {:ok, response, q, a}
        end
      end

      @spec del_opportunity(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def del_opportunity(%Token{token: token, lcode: lcode}, oid) do
        with {:ok, [response], q, a} <- Query.send("del_opportunity", [token, lcode, oid]) do
          {:ok, response, q, a}
        end
      end

      @spec fetch_soffers(%Token{}, any(), any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def fetch_soffers(%Token{token: token, lcode: lcode}, drom \\ nil, dto \\ nil, ancillary \\ 0) do
        with {:ok, [response], q, a} <- Query.send("fetch_soffers", [token, lcode, date_format(drom), date_format(dto), ancillary]) do
          {:ok, response, q, a}
        end
      end

      @spec new_soffer(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def new_soffer(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [response], q, a} <-
          Query.send("new_opportunity", [
            token,
            lcode,
            # Required arguments
            args[:name] || nil,
            args[:ddp] || nil,
            args[:id_policy] || nil,
            args[:dtype] || nil,
            args[:dvalue] || nil,
            args[:apply_to] || nil,
            args[:guarantee] || nil,
            args[:deposit] || nil,
            (if args[:dfrom], do: date_format(args[:dfrom]), else: nil),
            (if args[:dto], do: date_format(args[:dto]), else: nil),
            args[:wdays] || nil,
            args[:wdays_type] || nil,
            args[:must_advance] || nil,
            args[:max_advance] || nil,
            args[:must_stay] || nil,
            args[:max_stay] || nil,
            args[:must_rooms] || nil,
            args[:must_opps] || nil,
            args[:must_type] || nil,
            # Optional arguments
            args[:nations] || nil,
            args[:periods] || nil,
            args[:names] || nil,
            args[:descrs] || nil,
            args[:rplan] || nil
          ]) do
          {:ok, response, q, a}
        end
      end

      @spec mod_soffer(%Token{}, any(), any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def mod_soffer(%Token{token: token, lcode: lcode}, sid, args) do
        with {:ok, [response], q, a} <-
          Query.send("new_opportunity", [
            token,
            lcode,
            sid,
            # Optional arguments
            args[:name] || nil,
            args[:ddp] || nil,
            args[:id_policy] || nil,
            args[:dtype] || nil,
            args[:dvalue] || nil,
            args[:apply_to] || nil,
            args[:guarantee] || nil,
            args[:deposit] || nil,
            (if args[:dfrom], do: date_format(args[:dfrom]), else: nil),
            (if args[:dto], do: date_format(args[:dto]), else: nil),
            args[:wdays] || nil,
            args[:wdays_type] || nil,
            args[:must_advance] || nil,
            args[:max_advance] || nil,
            args[:must_stay] || nil,
            args[:max_stay] || nil,
            args[:must_rooms] || nil,
            args[:must_opps] || nil,
            args[:must_type] || nil,
            args[:nations] || nil,
            args[:periods] || nil,
            args[:names] || nil,
            args[:descrs] || nil,
            args[:rplan] || nil
          ]) do
          {:ok, response, q, a}
        end
      end

      @spec del_soffer(%Token{}, any()) :: {:ok, any(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def del_soffer(%Token{token: token, lcode: lcode}, sid) do
        with {:ok, [response], q, a} <- Query.send("del_soffer", [token, lcode, sid]) do
          {:ok, response, q, a}
        end
      end
    end
  end
end
