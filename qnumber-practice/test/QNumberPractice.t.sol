// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../src/QNumberPractice.sol";

contract QNumberPracticeTest {
    QNumberPractice qNumber;

    function setUp() public {
        qNumber = new QNumberPractice();
    }

    function testEncodeOne() public view {
        uint128 result = qNumber.encode(1);

        require(
            result == 18446744073709551616,
            "Incorrect encoding for 1"
        );
    }

    function testEncodeFive() public view {
        uint128 result = qNumber.encode(5);

        require(
            result == 92233720368547758080,
            "Incorrect encoding for 5"
        );
    }

    function testDecodeFivePointFive() public view {
        uint128 encodedFiveAndHalf =
            uint128((uint256(11) * (2**64)) / 2);

        uint64 result = qNumber.decode(encodedFiveAndHalf);

        require(result == 5, "Expected decoding to return 5");
    }

    function testMultiplyFiveByHalf() public view {
        uint128 a = qNumber.encode(5);
        uint128 b = uint128((uint256(2**64)) / 2);

        uint128 result = qNumber.multiplyQ64x64(a, b);

        uint128 expected =
            uint128((uint256(5) * (2**64)) / 2);

        require(result == expected, "Expected result to be 2.5");
    }

    function testMultiplyTwoByThree() public view {
        uint128 a = qNumber.encode(2);
        uint128 b = qNumber.encode(3);

        uint128 result = qNumber.multiplyQ64x64(a, b);
        uint128 expected = qNumber.encode(6);

        require(result == expected, "Expected result to be 6.0");
    }

    // Test 1: 5.0 ÷ 2.0 = 2.5

    function testDivideFiveByTwo() public view {
    uint128 a = qNumber.encode(5);
    uint128 b = qNumber.encode(2);

    uint128 result = qNumber.divideQ64x64(a, b);

    uint128 expected =
        uint128((uint256(5) * (2**64)) / 2);

    require(result == expected, "Expected result to be 2.5");

    
}

// Test 2: 1.0 ÷ 2.0 = 0.5

function testDivideOneByTwo() public view {
    uint128 a = qNumber.encode(1);
    uint128 b = qNumber.encode(2);

    uint128 result = qNumber.divideQ64x64(a, b);

    uint128 expected = uint128((uint256(2**64)) / 2);

    require(result == expected, "Expected result to be 0.5");
}


// Test 3: 1.0 ÷ 3.0 ≈ 0.333333…

function testDivideOneByThree() public view {
    uint128 a = qNumber.encode(1);
    uint128 b = qNumber.encode(3);

    uint128 result = qNumber.divideQ64x64(a, b);

    uint128 expected = uint128(uint256(2**64) / 3);

    require(result == expected, "Incorrect result for 1 divided by 3");
}

// Test 4: 0.0 ÷ 2.0 = 0.0

function testDivideZeroByTwo() public view {
    uint128 a = qNumber.encode(0);
    uint128 b = qNumber.encode(2);

    uint128 result = qNumber.divideQ64x64(a, b);

    require(result == 0, "Expected result to be zero");
}

// Test 5: 5.0 ÷ 0.0 must revert

function testDivideByZeroReverts() public {
    uint128 a = qNumber.encode(5);
    uint128 b = qNumber.encode(0);

    (bool success, ) = address(qNumber).call(
        abi.encodeWithSelector(
            QNumberPractice.divideQ64x64.selector,
            a,
            b
        )
    );

    require(!success, "Expected division by zero to revert");
}



// Integer Multiplication vs. Fixed-Point Multiplication

     //Test 1 — Integer 5 × Q64.64 0.5 = 2.5

     function testMultiplyIntegerFiveByHalf() public view {
    uint64 integerValue = 5;

    // Encode 0.5 in Q64.64.
    uint128 fixedPointValue =
        uint128(uint256(2**64) / 2);

    uint128 result = qNumber.multiplyIntegerByQ64x64(
        integerValue,
        fixedPointValue
    );

    // Expected Q64.64 representation of 2.5.
    uint128 expected =
        uint128((uint256(5) * (2**64)) / 2);

    require(result == expected, "Expected result to be 2.5");
}

// Test 2 — Integer 5 × Q64.64 1.0 = 5.0

function testMultiplyIntegerFiveByOne() public view {
    uint64 integerValue = 5;
    uint128 fixedPointValue = qNumber.encode(1);

    uint128 result = qNumber.multiplyIntegerByQ64x64(
        integerValue,
        fixedPointValue
    );

    uint128 expected = qNumber.encode(5);

    require(result == expected, "Expected result to be 5.0");
}


// Test 3 — Integer 0 × Q64.64 5.0 = 0.0

function testMultiplyIntegerZeroByFive() public view {
    uint64 integerValue = 0;
    uint128 fixedPointValue = qNumber.encode(5);

    uint128 result = qNumber.multiplyIntegerByQ64x64(
        integerValue,
        fixedPointValue
    );

    require(result == 0, "Expected result to be zero");
}

// Test 4 — Reject a result that exceeds uint128

function testMultiplyIntegerOverflowReverts() public {
    uint64 integerValue = 2;

    // Q64.64 representation of 2^63.
    uint128 fixedPointValue = uint128(uint256(1) << 127);

    (bool success, ) = address(qNumber).call(
        abi.encodeWithSelector(
            QNumberPractice.multiplyIntegerByQ64x64.selector,
            integerValue,
            fixedPointValue
        )
    );

    require(!success, "Expected multiplication overflow to revert");
}


}