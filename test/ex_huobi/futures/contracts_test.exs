defmodule ExHuobi.Futures.ContractsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Mock
  alias ExHuobi.Futures.Contracts
  doctest ExHuobi.Futures.Contracts

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get returns a list of contracts" do
    use_cassette "futures/contracts_ok" do
      assert {:ok, contracts} = Contracts.get()
      assert Enum.any?(contracts) == true
      assert %ExHuobi.Futures.Contract{} = contract = Enum.at(contracts, 0)
      assert contract.contract_code != nil
    end
  end

  test ".get bubbles errors" do
    with_mock HTTPoison, request: fn _url -> {:error, %HTTPoison.Error{reason: :timeout}} end do
      assert {:error, :timeout} = Contracts.get()
    end
  end
end
