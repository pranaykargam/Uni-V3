
# Uniswap V3 — Anki Revision Cards

> Click each card to reveal its answer.

<style>
.anki-card {
  border: 1px solid #6d5dfc;
  border-radius: 14px;
  padding: 18px;
  margin: 16px 0;
  background: #17152b;
  color: #f5f3ff;
}
.anki-question {
  font-size: 17px;
  font-weight: bold;
}
.anki-answer {
  margin-top: 14px;
  padding-top: 12px;
  border-top: 1px solid #6d5dfc;
  color: #c4b5fd;
}
</style>

<details>
<summary><strong>01 · What are reserves in Uniswap V2?</strong></summary>

The actual quantities of token0 and token1 held by the pool.

</details>

<details>
<summary><strong>02 · What does the V2 invariant represent?</strong></summary>

The constant-product relationship between reserve quantities.

\[
\boxed{k = x \times y}
\]

</details>

<details>
<summary><strong>03 · How do you calculate token0's price in token1 units?</strong></summary>

\[
\boxed{P = \frac{\text{reserve(token1)}}{\text{reserve(token0)}}}
\]

Example: 4,000 USDC / 2 ETH = 2,000 USDC/ETH.

</details>

<details>
<summary><strong>04 · What generally reduces price impact?</strong></summary>

Greater active liquidity relative to the trade size.

</details>

<details>
<summary><strong>05 · What is capital efficiency in Uniswap V3?</strong></summary>

Concentrating capital in selected price ranges instead of across the full curve.

</details>

<details>
<summary><strong>06 · What boundaries can an LP choose?</strong></summary>

A lower and an upper price boundary for the liquidity position.

</details>

<details>
<summary><strong>07 · When does an LP position become inactive?</strong></summary>

When the price moves outside its selected range; it stops earning swap fees there.

</details>

<details>
<summary><strong>08 · What are ticks in Uniswap V3?</strong></summary>

Predefined price boundaries where liquidity positions can begin or end.

</details>

<details>
<summary><strong>09 · What happens when a swap crosses a tick?</strong></summary>

The pool updates active liquidity and continues the swap if liquidity is available.

</details>

<details>
<summary><strong>10 · Is piecewise x × y = kᵢ the literal V3 implementation?</strong></summary>

No. It is a teaching model. V3 uses liquidity L, sqrtPriceX96 and tick boundaries.

</details>

## Audit checklist

- [ ] Verify token ordering and price direction.
- [ ] Check tick-spacing and boundary validation.
- [ ] Trace active-liquidity updates at tick crossings.
- [ ] Test swaps inside and outside liquidity ranges.
