defmodule ExHuobi.Swaps.ContractsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock
  alias ExHuobi.Swaps.Contracts
  doctest ExHuobi.Swaps.Contracts

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get returns a list of contracts" do
    use_cassette "futures/swaps_ok" do
      assert {:ok, contracts} = Contracts.get()
      assert Enum.any?(contracts) == true
      assert %ExHuobi.Swaps.Contract{} = contract = Enum.at(contracts, 0)
      assert contract.contract_code != nil
    end
  end

  test ".get bubbles errors" do
    with_mock HTTPoison, request: fn _url -> {:error, %HTTPoison.Error{reason: :timeout}} end do
      assert {:error, :timeout} = Contracts.get()
    end
  end
end
