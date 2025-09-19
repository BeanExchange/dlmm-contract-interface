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
- **LBFactory**: [`0x66c79078fA74a9d92B8A2a3320F28bf049B972d6`](https://testnet.monadexplorer.com/address/0x66c79078fA74a9d92B8A2a3320F28bf049B972d6)
- **LBRouter**: [`0xD01cfaa5D00d1cCf04379FB9147b7755D1685468`](https://testnet.monadexplorer.com/address/0xD01cfaa5D00d1cCf04379FB9147b7755D1685468)
- **LBQuoter**: [`0xB2254F3d6C504A4B1daFC05bc944b0E6157F1d14`](https://testnet.monadexplorer.com/address/0xB2254F3d6C504A4B1daFC05bc944b0E6157F1d14)
