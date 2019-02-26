defmodule WubookAPI.Prices do
  @moduledoc """
  API Methods for Availability operations
  """
  alias WubookAPI.Token
  # alias WubookAPI.Query

  def add_pricing_plan(%Token{token: _token, lcode: _lcode}, _name, _daily \\ 1) do
  end

  def add_vplan(%Token{token: _token, lcode: _lcode}, _pid, _dtype, _value) do
  end

  def del_plan(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def update_plan_name(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def get_pricing_plans(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def update_plan_rack(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def mod_vplans(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def update_plan_prices(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def fetch_plan_prices(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def convert_to_daily_plan(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def update_plan_periods(%Token{token: _token, lcode: _lcode}, _args) do
  end

  def delete_periods(%Token{token: _token, lcode: _lcode}, _args) do
  end
end
