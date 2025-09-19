// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {ILBFactory} from "./ILBFactory.sol";

/// @title Interface of the Dex Lens contract
/// @notice The interface needed to interact with the Dex Lens contract
interface IDexLens {

    /// @notice Enumerators of the different data feed types
    enum DataFeedType {
        DLMM,
        CHAINLINK
    }

    /**
     * @notice Structure for data feeds, contains the data feed's address and its type.
     * For DLMM, the`dfAddress` should be the address of the pair
     * For chainlink, the `dfAddress` should be the address of the aggregator
     */
    struct DataFeed {
        address collateralAddress;
        address dfAddress;
        uint88 dfWeight;
        DataFeedType dfType;
    }

    /**
     * @notice Structure for a set of data feeds
     * `datafeeds` is the list of all the data feeds
     * `indexes` is a mapping linking the address of a data feed to its index in the `datafeeds` list.
     */
    struct DataFeedSet {
        DataFeed[] dataFeeds;
        mapping(address => uint256) indexes;
    }

    /**
     * @notice List of trusted tokens
     */
    struct TrustedTokens {
        address[] tokens;
    }

    event DataFeedAdded(address token, DataFeed dataFeed);
    event DataFeedsWeightSet(address token, address dfAddress, uint256 weight);
    event DataFeedRemoved(address token, address dfAddress);
    event TrustedTokensSet(uint256 indexed level, address[] tokens);

    function getWNative() external view returns (address wNative);
    function getFactory() external view returns (ILBFactory factory);
    function getDataFeeds(address token) external view returns (DataFeed[] memory dataFeeds);
    function getTokenPriceUSD(address token) external view returns (uint256 price);
    function getTokenPriceNative(address token) external view returns (uint256 price);
    function getTokensPricesUSD(address[] calldata tokens) external view returns (uint256[] memory prices);
    function getTokensPricesNative(address[] calldata tokens) external view returns (uint256[] memory prices);

    function addDataFeed(address token, DataFeed calldata dataFeed) external;
    function setDataFeedWeight(address token, address dfAddress, uint88 newWeight) external;
    function removeDataFeed(address token, address dfAddress) external;
    function setTrustedTokensAt(uint256 level, address[] calldata tokens) external;
    function addDataFeeds(address[] calldata tokens, DataFeed[] calldata dataFeeds) external;
    function setDataFeedsWeights(
        address[] calldata _tokens,
        address[] calldata _dfAddresses,
        uint88[] calldata _newWeights
    ) external;
    function removeDataFeeds(address[] calldata tokens, address[] calldata dfAddresses) external;
}