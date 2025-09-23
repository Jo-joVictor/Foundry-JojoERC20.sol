// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import  {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Jojo is ERC20, ERC20Burnable, Ownable {
    
     constructor() ERC20("Jojo", "JOJO") {
        // Set the owner
        _transferOwnership(msg.sender);
        
        // Mint 1 million tokens to the contract deployer
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    /**
     * @dev Mint new tokens (only owner can call this)
     * @param to Address to receive the minted tokens
     * @param amount Amount of tokens to mint
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Override decimals to ensure it's 18 (default but explicit)
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
}