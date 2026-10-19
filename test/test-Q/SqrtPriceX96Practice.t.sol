
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.24;

 import "forge-std/Test.sol";

 contract SqrtPriceX96PracticeTest is Test {
     uint256 internal constant Q96 = 2 ** 96;

     /// @notice sqrtPrice = 2 => price = 4
     function testPriceFour() public pure {
         uint160 sqrtPriceX96 = uint160(2 * Q96);

         uint256 sqrtPrice = uint256(sqrtPriceX96) / Q96;
         uint256 price = sqrtPrice * sqrtPrice;

         assertEq(sqrtPrice, 2);
         assertEq(price, 4);
     }

     /// @notice sqrtPrice = 3 => price = 9
     function testPriceNine() public pure {
         uint160 sqrtPriceX96 = uint160(3 * Q96);

         uint256 sqrtPrice = uint256(sqrtPriceX96) / Q96;
         uint256 price = sqrtPrice * sqrtPrice;

         assertEq(sqrtPrice, 3);
         assertEq(price, 9);
     }

     /// @notice sqrtPrice = 0.5 => price = 0.25 (Q96-scaled)
     function testPriceQuarter() public pure {
         uint160 sqrtPriceX96 = uint160(Q96 / 2);

         // Keep the result in Q96 fixed-point representation.
         uint256 priceX96 =
             (uint256(sqrtPriceX96) * uint256(sqrtPriceX96)) / Q96;

         assertEq(priceX96, Q96 / 4);
     }
 }
