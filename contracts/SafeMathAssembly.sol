// SPDX-License-Identifier: GPL-3.0
pragma solidity <0.8.0;

// change it to a library and change all public to internal if you want to use as library

// TODO: Support for revert messages

/**
 * The SafeMath Library written in inline-assembly
 */
contract SafeMathAssembly {
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let result := add(x, y)
            if lt(result, x) {
                revert(0x00, 32)
            }
            let loc := mload(0x40)
            mstore(loc, result)
            return(loc, 32)
        }
    }

    function sub(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            if lt(x, y) {
                revert(0x00, 32)
            }
            let result := sub(x, y)
            let loc := mload(0x40)
            mstore(loc, result)
            return(loc, 32)
        }
    }

    function mul(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let result := mul(x, y)
            let loc := mload(0x40)
            mstore(loc, result)

            if eq(div(result, x), y) {
                return(loc, 32)
            }

            revert(0x00, 32)
        }
    }

    function div(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            if eq(y, 0) {
                revert(0x00, 32)
            }
            let result := div(x, y)
            let loc := mload(0x40)
            mstore(loc, result)

            return(loc, 32)
        }
    }

    function mod(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            if eq(y, 0) {
                revert(0x00, 32)
            }
            let result := mod(x, y)
            let loc := mload(0x40)
            mstore(loc, result)

            return(loc, 32)
        }
    }
}
