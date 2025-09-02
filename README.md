# FundMe - Decentralized Funding Smart Contract

> This Solidity project implements a decentralized funding contract deployed on the Sepolia Ethereum testnet.  
> Contributors fund with ETH, converted to USD via Chainlink oracles to enforce minimum funding.  
> The owner can withdraw all collected funds securely, demonstrating transparent on-chain fund management.

---

## Contracts Overview

### 1) **AggregatorV3Interface.sol**  
> Interface to Chainlink price feeds for fetching real-time ETH/USD price data.

### 2) **PriceConverter.sol**  
> Library to interact with Chainlink's ETH/USD price feed.  
- Retrieves latest ETH price.  
- Converts ETH amounts to USD equivalents.  
- Returns aggregator version info.

### 3) **FundMe.sol**  
> Main contract enabling users to fund the project with ETH.  
- Enforces a minimum funding ETH amount of $1 USD equivalent.  
- Tracks funders and their funded amounts.  
- Owner (deployer) can withdraw all funds and reset state.  
- Supports direct ETH transfers via `receive()` and `fallback()` functions.

---

## How the Contract Works

- Uses Chainlink oracles to convert sent ETH amount to USD value.  
- Requires minimum funding equivalent to $1 USD to accept funds.  
- Records each funder's contribution.  
- Owner can withdraw total funds with `WITHDRAW()`.  
- Any ETH sent directly triggers the funding function.

---

## Usage Instructions.

### View & Interact on Sepolia Etherscan  

- Go to [Sepolia Etherscan](https://sepolia.etherscan.io/).  
- Search for your deployed contract address.  
- Explore **Read Contract** tab to view public state like funders and amounts.  
- Use **Write Contract** tab to interact functions like `FUND()` and `WITHDRAW()` (connect MetaMask required).

### Fund the Contract

- Connect MetaMask wallet set to Sepolia testnet.  
- Acquire Sepolia test ETH:  
  - Claim free ETH every 24hr at [Google Cloud Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)  
  - Or mine/test claim via [Sepolia Faucet PK910](https://sepolia-faucet.pk910.de/#/)  
- Call `FUND()` with minimum 1 USD worth ETH supported by the contract to contribute.
  (You can check the and compare the price on [Ethereum Uint Converter](https://eth-converter.com/))

### Withdraw Funds (Owner only)

- Contract owner (deployer) can call `WITHDRAW()` to safely collect all funds.

---

## Why Use Etherscan?

- Transparency: Everyone can verify the contract code and transactions.  
- Trust: Shows secure fund management is in-place and auditable on-chain.  
- Professionalism: Easy public access builds confidence for contributors.  
- Extended Interaction: Allows users to explore contract functions beyond your UI.

---

## Summary

- Demonstrates live price feed integration by Chainlink oracles.  
- Secure decentralized funding with minimum amount checks.  
- Clean ownership pattern and withdrawal logic.  
- Facilitates transparent and trustable funding experience on Sepolia.

---

## Useful Links

- [Remix IDE](https://remix.ethereum.org)  
- [Sepolia Etherscan](https://sepolia.etherscan.io)  
- [Chainlink Documentation](https://docs.chain.link/docs/get-the-latest-price)  
- [Google Cloud Sepolia Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)  
- [Sepolia Faucet PK910](https://sepolia-faucet.pk910.de/#/)
