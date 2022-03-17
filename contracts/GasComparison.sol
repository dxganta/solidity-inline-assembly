// SPDX-License-Identifier: GPL-3.0
pragma solidity <0.8.0;

import "./libraries/SafeMath.sol";

contract MultipleAdditions {
    uint256 a = 69;
    uint256 b = 36;

    /// @notice addition in assembly without overflow check
    function addAssembly(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let result := add(x, y)
            let loc := mload(0x40)
            mstore(loc, result)
            return(loc, 32)
        }
    }

    /// @notice normal addition without using solidity
    function normalAdd(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }

    /// @notice addition with overflow check using yul
    function safeAddAssembly(uint256 x, uint256 y)
        public
        pure
        returns (uint256)
    {
        assembly {
            let result := add(x, y)
            let loc := mload(0x40)
            mstore(loc, result)
            if lt(result, x) {
                revert(loc, 32)
            }
            return(loc, 32)
        }
    }

    /// @notice safe addtion using the safemath library
    function normalSafeAdd(uint256 x, uint256 y) public pure returns (uint256) {
        return SafeMath.add(x, y);
    }
}

contract GasComparison is MultipleAdditions {
    uint256 public val;

    function gasAddAssembly() external {
        val = addAssembly(5, 6);
    }

    function gasnormalAdd() external {
        val = normalAdd(5, 6);
    }

    function gasSafeAddAssembly() external {
        val = safeAddAssembly(5, 6);
    }

    function gasNormalSafeAdd() external {
        val = normalSafeAdd(5, 6);
    }
}
