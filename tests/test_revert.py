from brownie import (
    accounts,
    AssemblyRevert
)

import brownie

def test_revert():
    dev = accounts[0]
    contract = AssemblyRevert.deploy({"from": dev})

    with brownie.reverts("Multicall3: call failed"):
        contract.throwRevert()