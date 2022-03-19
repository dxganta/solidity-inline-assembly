pragma solidity <0.8.0;

/**
    Contract showing how to revert in assembly 
 */
contract AssemblyRevert {
    function throwRevert() public {
        assembly {
            // set "Error(string)" signature: bytes32(bytes4(keccak256("Error(string)")))
            mstore(
                0x00,
                0x08c379a000000000000000000000000000000000000000000000000000000000
            )
            // set data offset
            mstore(
                0x04,
                0x0000000000000000000000000000000000000000000000000000000000000020
            )
            // set length of revert string
            mstore(
                0x24,
                0x0000000000000000000000000000000000000000000000000000000000000017
            )
            // set revert string: bytes32(abi.encodePacked("Multicall3: call failed"))
            mstore(
                0x44,
                0x4d756c746963616c6c333a2063616c6c206661696c6564000000000000000000
            )
            revert(0x00, 0x84)
        }
    }
}
