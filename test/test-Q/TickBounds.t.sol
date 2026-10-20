// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import {TickMath} from "v3-core/contracts/libraries/TickMath.sol";

contract TickBoundsTest {
    function testMinTick() external pure {
        uint160 sqrtPriceX96 = TickMath.getSqrtRatioAtTick(TickMath.MIN_TICK);
        assert(sqrtPriceX96 == TickMath.MIN_SQRT_RATIO);
    }

    function testMaxTick() external pure {
        uint160 sqrtPriceX96 = TickMath.getSqrtRatioAtTick(TickMath.MAX_TICK);
        assert(sqrtPriceX96 == TickMath.MAX_SQRT_RATIO);
    }

    function testTickZero() external pure {
        uint160 sqrtPriceX96 = TickMath.getSqrtRatioAtTick(0);
        assert(sqrtPriceX96 == uint160(1) << 96);
    }
}