defmodule WubookAPI.Policies do
  @moduledoc """
  API Methods for Policy operations
  """
  alias WubookAPI.Token
  # alias WubookAPI.Query

  def fetch_policies(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def new_policy(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def mod_policy(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def del_policy(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def fetch_policy_calendar(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def set_policy_calendar(%Token{token: _token, lcode: _lcode}, _args) do
  end
end
