//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINI_USD = 1e18 ;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }


    function FUND() public payable {
        require(msg.value.GetConversionRate() >= MINI_USD, "Didn't send enough ETH");  // 1e18 = 1ETH = 1000000000000000000 = 1* 10**18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        
    }

    function WITHDRAW()public onlyOwner{
        require(msg.sender == i_owner, "Must be OWNER !!!!");
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){  // funderIndex++ is equal to say funderIndex = funderIndex + 1
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);

        //actually withdraw the funds

        //call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require (callSuccess, "Call FAILED ! ");
     
    }
    
   modifier onlyOwner(){
    // require(msg.sender == i_owner, "Sender is not OWNER !!!!");
    if (msg.sender != i_owner){ revert NotOwner(); }
    _;
   }

   // what if someone sends this contract ETH without calling the FUND function . 

   receive() external payable {
    FUND();
   }

   fallback() external payable {
    FUND();
   }
}