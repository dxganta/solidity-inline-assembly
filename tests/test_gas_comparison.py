from brownie import (
    accounts,
    interface,
    GasComparison
)

def test_gas_comparison():
    dev = accounts[0]

    g = GasComparison.deploy({"from": dev})

    g.gasAddAssembly({"from": dev})
    g.gasnormalAdd({"from": dev})
    g.gasSafeAddAssembly({"from": dev})
    g.gasNormalSafeAdd({"from": dev})
