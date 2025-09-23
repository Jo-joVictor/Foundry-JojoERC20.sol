// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {Jojo} from "../src/JojoERC20.sol";

contract JojoTest is Test {
    Jojo public jojo;
    address public owner = address(1);
    address public alice = address(2);
    address public bob = address(3);

    uint256 public constant INITIAL_SUPPLY = 1000000 * 10**18;

    function setUp() public {
        vm.prank(owner);
        jojo = new Jojo();
    }

    function testInitialState() public view {
        assertEq(jojo.name(), "Jojo");
        assertEq(jojo.symbol(), "JOJO");
        assertEq(jojo.decimals(), 18);
        assertEq(jojo.totalSupply(), INITIAL_SUPPLY);
        assertEq(jojo.owner(), owner);
        assertEq(jojo.balanceOf(owner), INITIAL_SUPPLY);
    }

    function testTransfer() public {
        uint256 amount = 1000 * 10**18;
        
        vm.prank(owner);
        bool success = jojo.transfer(alice, amount);
        
        assertTrue(success);
        assertEq(jojo.balanceOf(alice), amount);
        assertEq(jojo.balanceOf(owner), INITIAL_SUPPLY - amount);
    }

    function testTransferFailsWithInsufficientBalance() public {
        uint256 amount = INITIAL_SUPPLY + 1;
        
        vm.prank(owner);
        vm.expectRevert();
        jojo.transfer(alice, amount);
    }

    function testApprove() public {
        uint256 amount = 500 * 10**18;
        
        vm.prank(owner);
        bool success = jojo.approve(alice, amount);
        
        assertTrue(success);
        assertEq(jojo.allowance(owner, alice), amount);
    }

    function testTransferFrom() public {
        uint256 amount = 200 * 10**18;
        
        // Owner approves Alice to spend tokens
        vm.prank(owner);
        jojo.approve(alice, amount);
        
        // Alice transfers from owner to bob
        vm.prank(alice);
        bool success = jojo.transferFrom(owner, bob, amount);
        
        assertTrue(success);
        assertEq(jojo.balanceOf(bob), amount);
        assertEq(jojo.balanceOf(owner), INITIAL_SUPPLY - amount);
        assertEq(jojo.allowance(owner, alice), 0);
    }

    function testTransferFromFailsWithoutApproval() public {
        uint256 amount = 100 * 10**18;
        
        vm.prank(alice);
        vm.expectRevert();
        jojo.transferFrom(owner, bob, amount);
    }

    function testMint() public {
        uint256 mintAmount = 500 * 10**18;
        
        vm.prank(owner);
        jojo.mint(alice, mintAmount);
        
        assertEq(jojo.balanceOf(alice), mintAmount);
        assertEq(jojo.totalSupply(), INITIAL_SUPPLY + mintAmount);
    }

    function testMintFailsForNonOwner() public {
        uint256 mintAmount = 100 * 10**18;
        
        vm.prank(alice);
        vm.expectRevert();
        jojo.mint(bob, mintAmount);
    }

    function testBurn() public {
        uint256 burnAmount = 1000 * 10**18;
        
        // Transfer some tokens to alice first
        vm.prank(owner);
        jojo.transfer(alice, burnAmount * 2);
        
        // Alice burns her tokens
        vm.prank(alice);
        jojo.burn(burnAmount);
        
        assertEq(jojo.balanceOf(alice), burnAmount);
        assertEq(jojo.totalSupply(), INITIAL_SUPPLY - burnAmount);
    }

    function testBurnFailsWithInsufficientBalance() public {
        uint256 burnAmount = 1000 * 10**18;
        
        vm.prank(alice);
        vm.expectRevert();
        jojo.burn(burnAmount);
    }

    function testMultipleApprovals() public {
        uint256 amount1 = 100 * 10**18;
        uint256 amount2 = 200 * 10**18;
        
        vm.startPrank(owner);
        jojo.approve(alice, amount1);
        assertEq(jojo.allowance(owner, alice), amount1);
        
        jojo.approve(alice, amount2);
        assertEq(jojo.allowance(owner, alice), amount2);
        vm.stopPrank();
    }

    function testOwnershipTransfer() public {
        vm.prank(owner);
        jojo.transferOwnership(alice);
        
        assertEq(jojo.owner(), alice);
    }

    function testOwnershipTransferFailsForNonOwner() public {
        vm.prank(alice);
        vm.expectRevert();
        jojo.transferOwnership(bob);
    }

    function testRenounceOwnership() public {
        vm.prank(owner);
        jojo.renounceOwnership();
        
        assertEq(jojo.owner(), address(0));
    }

    function testFuzzTransfer(uint256 amount) public {
        vm.assume(amount <= INITIAL_SUPPLY);
        
        vm.prank(owner);
        bool success = jojo.transfer(alice, amount);
        
        assertTrue(success);
        assertEq(jojo.balanceOf(alice), amount);
        assertEq(jojo.balanceOf(owner), INITIAL_SUPPLY - amount);
    }

    function testFuzzMint(uint256 amount) public {
        vm.assume(amount < type(uint256).max - INITIAL_SUPPLY);
        
        vm.prank(owner);
        jojo.mint(alice, amount);
        
        assertEq(jojo.balanceOf(alice), amount);
        assertEq(jojo.totalSupply(), INITIAL_SUPPLY + amount);
    }
}