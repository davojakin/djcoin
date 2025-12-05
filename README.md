# djcoin

A simple fungible token (FT) smart contract called **DJCoin**, built with
[Clarity](https://docs.stacks.co/write-smart-contracts/clarity-language) and
managed using [Clarinet](https://docs.hiro.so/clarinet).

DJCoin implements a minimal fungible token with:

- Minting restricted to the contract owner (the deployer)
- Transfers between principals
- Read-only views for balances, total supply, and owner

---

## Project structure

This project was bootstrapped with `clarinet new .` and `clarinet contract new djcoin`.

Key files:

- `Clarinet.toml` – Clarinet project configuration
- `contracts/djcoin.clar` – DJCoin Clarity smart contract
- `settings/*.toml` – Network configuration for Devnet/Testnet/Mainnet
- `tests/djcoin.test.ts` – Example Vitest test file for the contract

---

## Prerequisites

- [Clarinet](https://docs.hiro.so/clarinet) installed and available on your `PATH`
- Node.js and npm (for running TypeScript tests with Vitest)

You can verify Clarinet is installed with:

```bash
clarinet --version
```

---

## Using the DJCoin contract

All commands below are intended to be run from the project root directory:

```bash
cd /home/anthony/Documents/GitHub/djcoin
```

### 1. Check contract syntax

Run Clarinet’s static checks against all contracts:

```bash
clarinet check
```

### 2. Explore with the Clarinet console (optional)

Start an interactive console to call functions and inspect state:

```bash
clarinet console
```

Inside the console, you can call functions like:

```clarity
(contract-call? .djcoin mint u1000 tx-sender)
(contract-call? .djcoin transfer u100 tx-sender 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WKDTFJ9AHA)
(read-only-call? .djcoin get-balance tx-sender)
(read-only-call? .djcoin get-total-supply)
```

Adjust the principals above to match accounts available in your simnet.

### 3. Running tests (optional)

Install dependencies and run Vitest tests:

```bash
npm install
npm test
```

You can add more tests under the `tests/` directory to cover minting, transfers,
and read-only views.

---

## Contract interface

The `djcoin` contract exposes the following public and read-only functions:

### Public functions

- `mint (amount uint, recipient principal) : (response uint uint)`  
  Mint `amount` of DJCoin to `recipient`. Only callable by the contract owner.

- `transfer (amount uint, sender principal, recipient principal) : (response bool uint)`  
  Transfer `amount` of DJCoin from `sender` to `recipient`. The `tx-sender` must
  equal `sender`.

### Read-only functions

- `get-balance (account principal) : uint`  
  Returns the DJCoin balance of `account`.

- `get-total-supply () : uint`  
  Returns the total amount of DJCoin minted so far.

- `get-owner () : principal`  
  Returns the contract owner (the address that deployed the contract).

---

## Development workflow

1. Edit the contract in `contracts/djcoin.clar`.
2. Run `clarinet check` to validate contract syntax and basic semantics.
3. Add or update tests in `tests/djcoin.test.ts` and run `npm test`.
4. When ready, deploy using your preferred Stacks deployment tooling.
