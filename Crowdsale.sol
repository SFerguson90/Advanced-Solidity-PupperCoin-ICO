// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundableCrowdsale {

    constructor(
        
        string memory name,
        string memory symbol,
        address payable wallet,
        uint rate,
        uint goal,
        uint cap,
        uint opening_time,
        uint closing_time,

        Puppercoin token

    )
        // Constructor Parameters of inherited contracts

        Crowdsale(rate, wallet, token)
        CappedCrowdsale(cap)
        TimedCrowdsale(opening<time, closing_time)
        RefundableCrowdsale(goal)

        public
    {

    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;

    constructor(
        
        string memory name, // Name of Coin
        string memory symbol, // Symbol of Coin
        address payable wallet, // Banker Wallet
        uint goal, // Goal of ICO
        uint cap, // Max of ICO
        uint rate

    )
        public
    {
        //PupperCoin and Token Address
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);

        //PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.

        PupperCoinSale pupper_sale = new PupperCoinSale(
            name, symbol, wallet, goal, cap, rate, now, now+24 weeks, token
        );

        token_sale_address = address(pupper_sale);

        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
