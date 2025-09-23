# Jojo ERC20 Token

A simple ERC20 token built with OpenZeppelin, written in Solidity, and tested with Foundry.  
Supports minting, burning, transfers, and ownership controls.

---

## Features
-  ERC20 standard implementation
-  Burnable (holders can destroy tokens)
-  Mintable (only owner can mint new tokens)
-  Ownership management (transfer or renounce ownership)
-  1,000,000 JOJO minted at deployment to the owner

---

## Requirements
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Node.js (optional, if you want to use tools like Hardhat or scripts)
- A wallet (MetaMask, etc.)
- An RPC provider (Alchemy, Infura, QuickNode, etc.)
- Etherscan API key (for contract verification)

---

## Installation
Clone the repository:

```bash
git clone https://github.com/Jo-joVictor
cd jojo-erc20
forge install
