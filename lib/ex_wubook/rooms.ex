defmodule ExWubook.Rooms do
  @moduledoc """
  API Methods for Room operations
  """
  alias ExWubook.Token
  alias ExWubook.Query

  defmacro __using__(_) do
    quote do
      @doc """
      Fetch Rooms
      """
      @spec fetch_rooms(%Token{}, integer() | nil) :: {:ok, list, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def fetch_rooms(%Token{token: token, lcode: lcode}, ancillary \\ 0) do
        with {:ok, [rooms], q, a} <- Query.send("fetch_rooms", [token, lcode, ancillary]) do
          {:ok, rooms, q, a}
        end
      end

      @doc """
      Create Room
      """
      @spec new_room(%Token{}, map) :: {:ok, %{room_id: integer()}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def new_room(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [room_id], q, a} <-
              Query.send("new_room", [
                token,
                lcode,
                # Required arguments
                args[:woodoo] || 0,
                args[:name] || "",
                args[:beds] || 0,
                args[:defprice] || 0,
                args[:avail] || 0,
                args[:shortname] || "",
                args[:defboard] || "nb",
                # Optional arguments
                args[:names] || nil,
                args[:descriptions] || nil,
                args[:boards] || nil,
                args[:rtype] || nil,
                args[:min_price] || nil,
                args[:max_price] || nil
              ]) do
          {:ok, %{room_id: room_id}, q, a}
        end
      end

      @doc """
      Create Virtual Room
      """
      @spec new_virtual_room(%Token{}, map) :: {:ok, %{virtual_room_id: integer()}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def new_virtual_room(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [virtual_room_id], q, a} <-
              Query.send("new_virtual_room", [
                token,
                lcode,
                # Required arguments
                args[:rid] || nil,
                args[:woodoo] || 0,
                args[:name] || "",
                args[:beds] || 0,
                args[:children] || 0,
                args[:defprice] || 0,
                args[:shortname] || "",
                args[:defboard] || "nb",
                # Optional arguments
                args[:names] || nil,
                args[:descriptions] || nil,
                args[:boards] || nil,
                args[:dec_avail] || nil,
                args[:min_price] || nil,
                args[:max_price] || nil
              ]) do
          {:ok, %{virtual_room_id: virtual_room_id}, q, a}
        end
      end

      @doc """
      Update Room
      """
      @spec mod_room(%Token{}, map) :: {:ok, %{room_id: integer()}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def mod_room(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [room_id], q, a} <-
              Query.send("mod_room", [
                token,
                lcode,
                # Required arguments
                args[:rid] || nil,
                args[:name] || "",
                args[:beds] || 0,
                args[:defprice] || 0,
                args[:avail] || 0,
                args[:shortname] || "",
                args[:defboard] || "nb",
                # Optional arguments
                args[:names] || nil,
                args[:descriptions] || nil,
                args[:boards] || nil,
                args[:min_price] || nil,
                args[:max_price] || nil,
                args[:rtype] || nil,
                args[:woodoo_only] || nil
              ]) do
          {:ok, %{room_id: room_id}, q, a}
        end
      end

      @doc """
      Update Virtual Room
      """
      @spec mod_virtual_room(%Token{}, map) :: {:ok, %{virtual_room_id: integer()}, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def mod_virtual_room(%Token{token: token, lcode: lcode}, args) do
        with {:ok, [virtual_room_id], q, a} <-
              Query.send("new_virtual_room", [
                token,
                lcode,
                # Required arguments
                args[:rid] || nil,
                args[:name] || "",
                args[:beds] || 0,
                args[:children] || 0,
                args[:defprice] || 0,
                args[:shortname] || "",
                args[:defboard] || "nb",
                # Optional arguments
                args[:names] || nil,
                args[:descriptions] || nil,
                args[:boards] || nil,
                args[:dec_avail] || nil,
                args[:min_price] || nil,
                args[:max_price] || nil,
                args[:woodoo_only] || 0
              ]) do
          {:ok, %{virtual_room_id: virtual_room_id}, q, a}
        end
      end

      @doc """
      Remove Room or Virtual Room
      """
      @spec del_room(%Token{}, integer()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def del_room(%Token{token: token, lcode: lcode}, rid) do
        with {:ok, _, q, a} <- Query.send("del_room", [token, lcode, rid]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Get list of room images
      """
      @spec room_images(%Token{}, integer()) :: {:ok, list(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def room_images(%Token{token: token, lcode: lcode}, rid) do
        with {:ok, [images], q, a} <- Query.send("room_images", [token, lcode, rid]) do
          {:ok, images, q, a}
        end
      end

      @doc """
      WuBook can send a notification if rooms values are changed, for instance when a user updates the availability of his rooms on WuBook Extranet. The push_update_activation() method is used to setup an URL to which the notifications will be sent.
      """
      @spec push_update_activation(%Token{}, String.t()) :: {:ok, nil, String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def push_update_activation(%Token{token: token, lcode: lcode}, url) do
        with {:ok, _, q, a} <- Query.send("push_update_activation", [token, lcode, url]) do
          {:ok, nil, q, a}
        end
      end

      @doc """
      Get push update URL
      """
      @spec push_update_url(%Token{}) :: {:ok, String.t(), String.t(), String.t()} | {:error, any(), String.t(), String.t()}
      def push_update_url(%Token{token: token, lcode: lcode}) do
        with {:ok, [url], q, a} when url !== "" <- Query.send("push_update_url", [token, lcode]) do
          {:ok, nil, q, a}
        else
          {:ok, _, q, a} -> {:error, :url_is_not_defined, q, a}
        end
      end
    end
  end
end
