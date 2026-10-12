
### Uniswap V3 Learning Schedule

| Day | Focus | Practice |
|---|---|---|
| 1 | Price, ticks, and `sqrtPriceX96` | Write down how price maps to ticks and square-root price. |
| 2 | Liquidity math | Work through token amounts needed for liquidity at different price ranges. |
| 3 | Swap within one tick | Trace how a swap changes price and token amounts without crossing a tick. |
| 4 | Swap across a tick | Trace a tick crossing and how the active liquidity changes. |
| 5 | Swap simulator | Build a tiny simulator for price movement, tick crossings, and liquidity updates. |
| 6 | LP position lifecycle | Follow a position through minting, fee accrual, collection, and withdrawal. |
| 7 | Review | Re-trace the flows using core pool contracts first; then compare with the NFT position manager. |


## What is Uniswap?

- Uniswap is a **DEX** (decentralized exchange) built with smart contracts.
- It lets users swap tokens using **liquidity pools**, not a traditional order book.
- Liquidity providers (LPs) deposit token pairs; traders swap against those pools and pay fees to LPs. 
## Uniswap V1

- Used an **AMM**: traders trade directly with a pool of tokens.
- Example: give USDC, receive ETH; if you buy more ETH, the pool price rises.
- Every V1 pool had to include **ETH**.
- Problem: swapping USDC → another ERC-20 token needed multiple hops through ETH, costing extra gas and steps. 

## Uniswap V2

- Removed the requirement that every pool contain ETH.
- Allowed direct pools such as **USDC/BAT**.
- Enabled one-click token-to-token swaps.
- This made Uniswap much more popular and widely forked. 

## Uniswap V3: Main Idea

- Launched around **March 2021** on Ethereum mainnet and Optimism.
- Biggest upgrade: **Concentrated Liquidity**.
- Instead of spreading liquidity across all possible prices, LPs choose a **custom price range**. 

## Concentrated Liquidity

### V2 behavior

- Your liquidity is spread from price **0 to infinity**.
- Most of your capital is unused if the token price stays in a small range.
- You earn fewer fees for the same capital. 
### V3 behavior

- You choose a range, e.g. ETH between **$3,000 and $4,000**.
- Your capital is concentrated only in that range.
- This makes your capital more efficient and can earn much higher fees. 
## What Happens Outside the Range?

If price leaves your selected range:

- You **stop earning fees**.
- Your position becomes **one single token**.
- Example: if ETH crashes below your lower bound, your position becomes mostly ETH.
- If ETH rises above your upper bound, your position becomes mostly the other token, such as USDC. 

## Limit-Order View

A V3 position is similar to placing two limit orders:

- Lower bound: like a **limit buy order**.
- Upper bound: like a **limit sell order**.
- Example: liquidity between $3,000–$4,000 means you effectively buy ETH below $3,000 and sell ETH above $4,000. 

## Capital Efficiency Example

Suppose both LPs deposit **$10,000** in an ETH/USDC pool:

| LP type | Price range | Example yearly fees |
|---|---:|---:|
| V2-style full-range LP | 0 to infinity | $400 |
| V3 concentrated LP | $1,500–$2,500 | $3,332 |

- Same deposit, but the concentrated LP earns about **8.33x** more in this example.
- Alternatively, the concentrated LP could deposit only about **$1,200** and earn similar fees to the full-range LP. 

## Stablecoin Pools

- Concentrated liquidity is especially useful for stablecoin pairs such as **DAI/USDC**.
- Their price stays very close to $1, so a narrow range captures most trading activity.
- The video gives an example capital multiplier of up to **200x** for stablecoin pools.
- A very narrow range of about **0.1%** can reach up to **4,000x** capital efficiency. 

## Active vs Inactive Liquidity

- **Active liquidity:** price is inside your chosen range; you earn fees.
- **Inactive liquidity:** price is outside your range; no fees are earned.
- Your position still holds one asset, but it no longer actively provides trading liquidity. 

## NFT LP Positions

- In V2, LP tokens were fungible: one ETH/USDC LP token equaled another.
- In V3, each position has a unique price range and position data.
- Therefore, Uniswap V3 represents LP positions as **NFTs**.
- The NFT proves ownership of a specific liquidity position and can be used to withdraw it.

## Other V3 Improvements

- V3 included optimizations that made swaps cheaper in gas.
- Uniswap V3 originally used a restrictive license, preventing direct copying/forking for two years.
- This was important because many DEXes were direct Uniswap forks.

## Audit-Relevant Points

- Track whether the current price is **inside or outside** the position range.
- Remember: out-of-range means **no fees**, not zero value.
- A narrow range gives higher fee efficiency but more exposure to price movement and impermanent loss.
- V3 positions are NFTs, so ownership, approvals, transfers, and position accounting differ from V2 LP tokens. 

## One-Line Summary

**Uniswap V3 lets LPs choose where their liquidity works, making capital more efficient but adding range risk, impermanent loss, and NFT-based position management.** [youtube](https://www.youtube.com/watch?v=ClWR1570UQw)