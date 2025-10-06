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
- **LBFactory**: [`0xF5f8786bBF172ABf4009aF5BCcbD6dC1A6020241`](https://testnet.monadexplorer.com/address/0xF5f8786bBF172ABf4009aF5BCcbD6dC1A6020241)
- **LBRouter**: [`0x04697F2675B8E37406Bfe217161F2e876410138D`](https://testnet.monadexplorer.com/address/0x04697F2675B8E37406Bfe217161F2e876410138D)
- **LBQuoter**: [`0xa2f59b5a806ACD8cac4b0d92E7AAd47676b826DA`](https://testnet.monadexplorer.com/address/0xa2f59b5a806ACD8cac4b0d92E7AAd47676b826DA)
