# Bean Exchange - DLMM Contract Interfaces

Solidity interfaces for the Discretized Liquidity Market Maker (DLMM) protocol - an advanced AMM with concentrated liquidity and dynamic fees.

## Interfaces

### Core
- **`ILBPair`** - Main liquidity pool interface for swaps, liquidity, and flash loans
- **`ILBFactory`** - Factory for creating and managing LB pairs
- **`ILBRouter`** - User-facing router for all protocol interactions

### Token & Rewards
- **`ILBToken`** - ERC-1155 token representing liquidity positions
- **`ILBRewarder`** - Multi-token reward distribution system
- **`ILBRewarderVault`** - Secure vault for reward tokens

### Utilities
- **`IDexLens`** - Price aggregation from multiple data sources
- **`ILBHooks`** - Customizable hooks for extending functionality
- **`ILBFlashLoanCallback`** - Flash loan callback interface

## Key Features

- **Concentrated Liquidity** - Capital efficiency through price range selection
- **Dynamic Fees** - Automatic fee adjustment based on volatility
- **Multi-Reward System** - Distribute multiple reward tokens to LPs
- **Flash Loans** - Built-in flash loan support
- **Price Oracles** - On-chain TWAP and external oracle integration

## Contract address

### Monad Testnet
- **LBFactory**: [`0xed982201856C409688CEB693e65E0fc89b5fc619`](https://testnet.monadexplorer.com/address/0xed982201856C409688CEB693e65E0fc89b5fc619)
- **LBRouter**: [`0xCB07cdb7253135130481b1632627769828Bd80F1`](https://testnet.monadexplorer.com/address/0xCB07cdb7253135130481b1632627769828Bd80F1)
- **LBQuoter**: [`0xA58De59e1EC813D2C97dEEC30c2d4fABf2B9d8D8`](https://testnet.monadexplorer.com/address/0xA58De59e1EC813D2C97dEEC30c2d4fABf2B9d8D8)
