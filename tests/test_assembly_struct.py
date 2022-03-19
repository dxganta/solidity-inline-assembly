from brownie import (
    accounts,
    interface,
    StructAssembly
)

def test_assembly_struct():
    s = StructAssembly.deploy({"from": accounts[0]})

    a = 69
    b = 420
    c = 6969

    (x, y, z) = s.testMFunc(a,b,c)

    assert (a == x)
    assert (b == y)
    assert (c == z)

    (x,y,z) = s.calldataloadtest([(a,b,c)])

    assert (a == x)
    assert (b == y)
    assert (c == z)

    (x,y,z) = s.testPackedMLoad((a,b,c))

    assert (a == x)
    assert (b == y)
    assert (c == z)