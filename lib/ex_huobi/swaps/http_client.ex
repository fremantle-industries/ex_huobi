defmodule ExHuobi.Swaps.HTTPClient do
  use ExHuobi.Rest.HTTPClient

  def rest_protocol, do: Application.get_env(:ex_huobi, :swaps_rest_protocol, "https://")

  def domain, do: Application.get_env(:ex_huobi, :swaps_domain, "api.hbdm.com")

  def origin, do: rest_protocol() <> domain()

  def api_path, do: Application.get_env(:ex_huobi, :swaps_api_path, "/swap-api/v1")
end
