# Jojo ERC20 Token

A standard ERC20 token implementation built with Solidity and Foundry, featuring minting, burning, and ownership management capabilities through OpenZeppelin contracts.

## Features

- **Standard ERC20**: Full compliance with ERC20 token standard
- **Burnable tokens**: Token holders can burn their own tokens
- **Mintable by owner**: Contract owner can mint new tokens
- **Ownership management**: Transferable and renounceable ownership
- **Initial supply**: 1,000,000 JOJO tokens minted to deployer
- **18 decimals**: Standard token decimal configuration
- **Gas optimized**: Built on OpenZeppelin's battle-tested implementations

## Quick Start

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Installation

```bash
git clone <your-repo-url>
cd jojo-erc20
forge install
```

### Environment Setup

Create a `.env` file:
```bash
PRIVATE_KEY=your_private_key
SEPOLIA_RPC_URL=your_sepolia_rpc_url
ETHERSCAN_API_KEY=your_etherscan_api_key
```

## Usage

### Deploy

```bash
# Deploy to local anvil
forge script script/DeployJojoERC20.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to Sepolia testnet
forge script script/DeployJojoERC20.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```

### Interact with Token

```bash
# Check balance
cast call <TOKEN_ADDRESS> "balanceOf(address)(uint256)" <WALLET_ADDRESS> --rpc-url $SEPOLIA_RPC_URL

# Transfer tokens
cast send <TOKEN_ADDRESS> "transfer(address,uint256)" <RECIPIENT> <AMOUNT> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY

# Approve spender
cast send <TOKEN_ADDRESS> "approve(address,uint256)" <SPENDER> <AMOUNT> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY

# Check allowance
cast call <TOKEN_ADDRESS> "allowance(address,address)(uint256)" <OWNER> <SPENDER> --rpc-url $SEPOLIA_RPC_URL

# Mint tokens (owner only)
cast send <TOKEN_ADDRESS> "mint(address,uint256)" <RECIPIENT> <AMOUNT> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY

# Burn tokens
cast send <TOKEN_ADDRESS> "burn(uint256)" <AMOUNT> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
```

## Contract Architecture

### Core Contract

- **Jojo.sol**: Main ERC20 token contract inheriting from OpenZeppelin

### Inheritance Structure

```
Jojo
├── ERC20 (OpenZeppelin)
├── ERC20Burnable (OpenZeppelin)
└── Ownable (OpenZeppelin)
```

### Key Functions

#### Standard ERC20 Functions

- `transfer(address to, uint256 amount)`: Transfer tokens to another address
- `approve(address spender, uint256 amount)`: Approve spender to use tokens
- `transferFrom(address from, address to, uint256 amount)`: Transfer tokens on behalf of another address
- `balanceOf(address account)`: Check token balance of an address
- `allowance(address owner, address spender)`: Check approved amount for spender
- `totalSupply()`: Get total token supply

#### Extended Functions

- `mint(address to, uint256 amount)`: Mint new tokens (owner only)
- `burn(uint256 amount)`: Burn tokens from caller's balance
- `decimals()`: Returns token decimals (18)
- `name()`: Returns token name ("Jojo")
- `symbol()`: Returns token symbol ("JOJO")

#### Ownership Functions

- `owner()`: Returns current contract owner
- `transferOwnership(address newOwner)`: Transfer ownership to new address
- `renounceOwnership()`: Remove owner, making contract ownerless

### Deployment Script

- **DeployJojoERC20.sol**: Deployment script for all networks

## Testing

Run the complete test suite:

```bash
# Run all tests
forge test

# Run with verbose output
forge test -vvv

# Run specific test
forge test --match-test testTransfer

# Generate coverage report
forge coverage
```

### Test Coverage

#### Core Functionality Tests

- **Initialization**: Token name, symbol, decimals, and initial supply
- **Transfers**: Standard token transfers and failure cases
- **Approvals**: Token approval mechanism and allowance tracking
- **TransferFrom**: Delegated transfers with approval
- **Minting**: Owner-only minting capability
- **Burning**: Token burning mechanism
- **Ownership**: Owner transfer and renouncement

#### Fuzz Tests

- **Transfer Fuzzing**: Random transfer amounts within valid range
- **Mint Fuzzing**: Random mint amounts up to uint256 max

#### Security Tests

- **Access Control**: Non-owner cannot mint tokens
- **Balance Validation**: Transfers fail with insufficient balance
- **Approval Validation**: TransferFrom fails without approval
- **Ownership Protection**: Non-owner cannot transfer ownership

## Token Details

**Jojo Token (JOJO)**
- Name: Jojo
- Symbol: JOJO
- Decimals: 18
- Initial Supply: 1,000,000 JOJO
- Standard: ERC20
- Burnable: Yes
- Mintable: Yes (owner only)
- Pausable: No
- Capped: No

## Security Features

- **OpenZeppelin Contracts**: Uses audited, industry-standard implementations
- **Owner-only Minting**: Prevents unauthorized token creation
- **Safe Math**: Solidity 0.8+ built-in overflow protection
- **Access Control**: Ownable pattern for privileged functions
- **Burn Protection**: Users can only burn their own tokens
- **Transfer Validation**: Automatic balance and allowance checks

## Gas Optimization

- Uses OpenZeppelin's optimized ERC20 implementation
- Efficient storage patterns with mappings
- No unnecessary state changes
- Minimal external calls

## Use Cases

- **Governance Token**: Use for DAO voting and governance
- **Utility Token**: In-app currency for dApps
- **Reward Token**: Distribute as rewards in DeFi protocols
- **Membership Token**: Grant access to exclusive features
- **Staking Token**: Use in staking mechanisms

## Development

### Project Structure

```
.
├── src/
│   └── JojoERC20.sol
├── script/
│   └── DeployJojoERC20.sol
├── test/
│   └── JojoTest.t.sol
└── README.md
```

### Adding New Features

To extend functionality:

1. Inherit from additional OpenZeppelin contracts
2. Add new functions with appropriate access control
3. Write comprehensive tests for new features
4. Update documentation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Resources

- [Foundry Documentation](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [ERC20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [Solidity Documentation](https://docs.soliditylang.org/)
