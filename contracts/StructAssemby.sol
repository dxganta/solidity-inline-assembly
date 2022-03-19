pragma solidity <0.8.0;
pragma experimental ABIEncoderV2;

/**
    mload(struct) loads the first param of the struct
    to load any subsequent params of the struct just go mload(struct + 32)

    use calldataload() for calldata
    use mload() for memory data
 */

contract StructAssembly {
    struct MyStruct {
        uint256 x;
        uint256 y;
        uint256 z;
    }

    function testMFunc(
        uint256 a,
        uint256 b,
        uint256 c
    )
        public
        pure
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        MyStruct memory data1 = MyStruct(a, b, c);
        return mloadTest(data1);
    }

    function mloadTest(MyStruct memory data)
        internal
        pure
        returns (
            uint256 _z,
            uint256 _w,
            uint256 _y
        )
    {
        assembly {
            _z := mload(data) // load the first param of the struct
            _w := mload(add(data, 0x20)) // load the second param of the struct, first param data location + 32 bytes
            _y := mload(add(data, 0x40)) // load third param, first param data location + 64 bytes
        }
    }

    /// @notice similar to the above function, but testing calldataload instead of mload
    function calldataloadtest(MyStruct[] calldata data)
        public
        pure
        returns (
            uint256 _z,
            uint256 _w,
            uint256 _y
        )
    {
        MyStruct calldata datai = data[0];

        assembly {
            _z := calldataload(datai)
            _w := calldataload(add(datai, 0x20))
            _y := calldataload(add(datai, 0x40))
        }
    }
}
