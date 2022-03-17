from brownie import (
    accounts,
    SafeMathAssembly
)

MaxUint256 = str(int(2 ** 256 - 1))


import brownie

def test_safemath():
    dev = accounts[0]
    x = 10
    y = 2

    safemath = SafeMathAssembly.deploy({"from": dev})

    assert safemath.add(x,y) == x + y
    assert safemath.sub(x,y) ==  x - y
    assert safemath.mul(x,y) == x * y
    assert safemath.div(x,y) == x // y
    assert safemath.mod(x,y) == x % y

    # should revert
    with brownie.reverts():
        safemath.add(MaxUint256, 1)

    with brownie.reverts():
        safemath.sub(1, 5)

    with brownie.reverts():
        safemath.mul(MaxUint256, 4)

    with brownie.reverts():
        safemath.div(5, 0)

    with brownie.reverts():
        safemath.mod(10, 0)