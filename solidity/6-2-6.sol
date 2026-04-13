// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    bool public isApproved;

    constructor (address _arbiter, address _beneficiary) payable{
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    event Approved(uint balance);

    function approve() external {
        require(msg.sender == arbiter);

		uint balance = address(this).balance;

		(bool sent, ) = beneficiary.call{ value: balance }("");

		require(sent, "Failed to send Ether");

		emit Approved(balance);
        
		isApproved = true;
    }
}