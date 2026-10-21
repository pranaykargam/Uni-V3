
// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

import "../lib/v3-core/contracts/libraries/TickMath.sol";
contract TickMathPracticeTest  {

   function test_TickZero() public {
    require(
        TickMath.getSqrtRatioAtTick(0) == uint160(1 << 96),
        "Tick zero ratio incorrect"
    );
}

function test_PositiveTickAboveOne() public {
    uint160 ratio100 = TickMath.getSqrtRatioAtTick(100);
    uint160 ratio0 = TickMath.getSqrtRatioAtTick(0);

    require(ratio100 > ratio0, "Positive tick ratio incorrect");
}

function test_NegativeTickBelowOne() public {
    uint160 ratioMinus100 = TickMath.getSqrtRatioAtTick(-100);
    uint160 ratio0 = TickMath.getSqrtRatioAtTick(0);

    require(ratioMinus100 < ratio0, "Negative tick ratio incorrect");
}
}