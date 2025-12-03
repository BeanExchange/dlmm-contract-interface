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
- **LBFactory**: [`0x8Bb9727Ca742C146563DccBAFb9308A234e1d242`](https://monadvision.com/address/0x8Bb9727Ca742C146563DccBAFb9308A234e1d242)
- **LBRouter**: [`0x721aC9E688E6b86F48b08DB2ba2D4B7bBBd12665`](https://monadvision.com/address/0x721aC9E688E6b86F48b08DB2ba2D4B7bBBd12665)
- **LBQuoter**: [`0xA398af902950081F2FBE3E16e5E474C2C72ae27a`](https://monadvision.com/address/0xA398af902950081F2FBE3E16e5E474C2C72ae27a)
