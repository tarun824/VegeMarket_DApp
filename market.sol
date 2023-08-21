// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VegetableMarket {
    uint public totalVegetablesPurchased;
    uint public netPriceSpent;
    uint public goodVegetablescount;
    uint public pricepervegp;
    address public admin;

    constructor() {
        admin = msg.sender;
    }
    
    function receiveInput(uint goodVegetables, uint badVegetables, uint priceperveg) public {
        require(msg.sender == admin, "Only admin can receive input");
        goodVegetablescount=goodVegetables;
        pricepervegp=priceperveg;
        totalVegetablesPurchased = goodVegetables + badVegetables;
        netPriceSpent = totalVegetablesPurchased * priceperveg; 
    }
    function itemsandamountpurchased() public view returns (uint,uint)
    {
        return ( totalVegetablesPurchased,netPriceSpent);
    }

    function calculateProfitOrLoss() public view returns (string memory, uint) {
        uint sellingPrice = ( goodVegetablescount * (pricepervegp+20) ); // Rs.20 is the fixed cost
        if (sellingPrice > netPriceSpent)
            return ("Profit", sellingPrice - netPriceSpent);
        else
            return ("Loss", netPriceSpent - sellingPrice);
    }
}