// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ILBRewarder
 * @dev Interface for LBRewarder logic contract
 */
interface ILBRewarder {
    // Structs
    struct Rewarder {
        uint256 emissionPerSecond;
        address rewardToken;
        bool exists;
    }
    
    // Events
    event RewarderAdded(address indexed rewardToken);
    event EmissionRateUpdated(address indexed rewardToken, uint256 oldRate, uint256 newRate);
    
    // Errors
    error TooManyRewarders();
    error RewarderAlreadyExists();
    error RewarderNotFound();
    
    // Constants
    function MAX_REWARDERS_PER_PAIR() external pure returns (uint256);
    function PRECISION_SHIFT() external pure returns (uint256);
    
    // View functions
    function rewarderVault() external view returns (address);
    
    function simulateRewardEmissions() external view returns (uint256[] memory emissions);
    
    function getRewarder(uint256 index) external view returns (
        address rewardToken,
        uint256 emissionPerSecond
    );
    
    function getAllRewarders() external view returns (Rewarder[] memory);
    
    function getRewarderCount() external view returns (uint256);
}