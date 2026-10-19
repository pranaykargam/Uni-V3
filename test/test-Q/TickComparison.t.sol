// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "@uniswap/v3-core/contracts/libraries/TickMath.sol";

contract TickComparisonTest {
    function testCalculateTickFromRealPoolPrice() public pure returns (int24) {
        uint160 sqrtPriceX96 = 1629469382397940298438175600676214;

        int24 calculatedTick = TickMath.getTickAtSqrtRatio(sqrtPriceX96);

        require(calculatedTick == 198638, "Tick mismatch");

        return calculatedTick;
    }

     function testTickAndSqrtPriceBoundaries() public pure {
        // Previously recorded pool square-root price
        uint160 sqrtPriceX96 =
            1629469382397940298438175600676214;

        // Previously recorded pool tick
        int24 storedTick = 198638;

        // Step 1: Calculate tick from the square-root price
        int24 calculatedTick =
            TickMath.getTickAtSqrtRatio(sqrtPriceX96);

        require(calculatedTick == storedTick, "Tick mismatch");

        // Step 2: Calculate boundary from the stored tick
        uint160 boundarySqrtPriceX96 =
            TickMath.getSqrtRatioAtTick(storedTick);

        // Step 3: Calculate boundary from the calculated tick
        uint160 calculatedBoundary =
            TickMath.getSqrtRatioAtTick(calculatedTick);

        // Both ticks are equal, so their boundaries must match
        require(
            boundarySqrtPriceX96 == calculatedBoundary,
            "Boundary mismatch"
        );

        // The original price must be at or above this tick's boundary
        require(
            sqrtPriceX96 >= calculatedBoundary,
            "Price below tick boundary"
        );
    }
}