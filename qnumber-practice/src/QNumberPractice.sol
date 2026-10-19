// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract QNumberPractice {
    uint256 constant SCALE = 2**64;

    function encode(uint64 value) public pure returns (uint128) {
        return uint128(uint256(value) * SCALE);
    }

    function decode(uint128 value) public pure returns (uint64) {
        return uint64(uint256(value) / SCALE);
    }

    function multiplyQ64x64(
        uint128 a,
        uint128 b
    ) public pure returns (uint128) {
        // 1. Multiply using a wider intermediate.
        uint256 product = uint256(a) * uint256(b);

        // 2. Restore the Q64.64 scaling.
        uint256 scaledResult = product / SCALE;

        // 3. Check that the result fits in uint128.
        require(
            scaledResult <= type(uint128).max,
            "Q64.64 multiplication overflow"
        );

        return uint128(scaledResult);
    }

    function divideQ64x64(
    uint128 a,
    uint128 b
) public pure returns (uint128) {
    // TODO 1: Reject division by zero.
    require(b != 0, "Division by zero");

    // TODO 2: Scale the numerator using a wider type.
    uint256 numerator = uint256(a) * SCALE;

    // TODO 3: Divide to restore the Q64.64 result.
    uint256 result = numerator / uint256(b);

    // TODO 4: Ensure the result fits in uint128.
    require(
        result <= type(uint128).max,
        "Q64.64 division overflow"
    );

    return uint128(result);
}


function multiplyIntegerByQ64x64(
    uint64 integerValue,
    uint128 fixedPointValue
) public pure returns (uint128) {
    // 1. Multiply the integer by the encoded fixed-point value.
    uint256 result =
        uint256(integerValue) * uint256(fixedPointValue);

    // 2. Ensure the result fits in uint128.
    require(
        result <= type(uint128).max,
        "Integer multiplication overflow"
    );

    // 3. Return the result in Q64.64 format.
    return uint128(result);
}
}