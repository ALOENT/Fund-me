//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

     function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (, int256 price, , , ) = priceFeed.latestRoundData(); // ✅ Correct destructuring
        require(price > 0, "Price feed returned invalid data");
        return uint256(price*1e10);
    }

    function GetConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD= (ethPrice * ethAmount) / 1e18 ;

        return ethAmountInUSD;
    }

    function GetVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }

}
