// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Escrow {
    event Funded(address funder, uint256 amount);
    mapping(address => uint256) public depositAmount; 
    function deposit() external payable {
        depositAmount[msg.sender] += msg.value;
        emit Funded(msg.sender, msg.value);
    }

    function withdraw() external {
        require(depositAmount[msg.sender] > 0, "Amount too insignificant to withdraw");

        (bool callSuccess, ) = payable(msg.sender).call{value: depositAmount[msg.sender]}("");        
        require(callSuccess, "Transfer failed");
        depositAmount[msg.sender]=0;
    }
}
