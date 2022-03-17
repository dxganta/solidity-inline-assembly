// SPDX-License-Identifier: GPL-3.0
pragma solidity <0.8.0;

contract AssemblyStorage {
    uint256 a = 69;
    uint256 b = 420;

    /// @notice reading a storage variable directly from storage using slot number
    function readFromStorage(uint256 slot) public view returns (uint256) {
        assembly {
            let loc := mload(0x40)
            mstore(loc, sload(slot))
            return(loc, 32)
        }
    }

    /// @notice adding number to storage variable at specified slot
    /// @param slot slot number of the storage variable that you want to add with
    /// @param num the number that you want to add to the storage variable
    function addToStorageVar(uint256 slot, uint256 num)
        public
        view
        returns (uint256)
    {
        assembly {
            let value := add(sload(slot), num)
            mstore(0x00, value)
            return(0x00, 32)
        }
    }
}
