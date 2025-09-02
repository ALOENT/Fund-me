
// File: @chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol


pragma solidity ^0.8.0;

// solhint-disable-next-line interface-starts-with-i
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

// File: contracts/PriceConverter.sol

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;


library PriceConverter{

     function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
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
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

}

// File: contracts/FundMe.sol


pragma solidity ^0.8.8;


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