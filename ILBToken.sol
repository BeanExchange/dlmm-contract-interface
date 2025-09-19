// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

/**
 * @title Liquidity Book Token Interface
 * @notice Interface to interact with the LBToken.
 */
interface ILBToken {
    error LBToken__AddressThisOrZero();
    error LBToken__InvalidLength();
    error LBToken__SelfApproval(address owner);
    error LBToken__SpenderNotApproved(address from, address spender);
    error LBToken__TransferExceedsBalance(address from, uint256 id, uint256 amount);
    error LBToken__BurnExceedsBalance(address from, uint256 id, uint256 amount);
    
    error LBToken__PositionLocked(address account, uint256 id, uint256 until);
    error LBToken__FeeOverflow();
    error LBToken__InvalidLockTime();
    error LBToken__InsufficientAccumulatedFees();

    event TransferBatch(
        address indexed sender, address indexed from, address indexed to, uint256[] ids, uint256[] amounts
    );

    event ApprovalForAll(address indexed account, address indexed sender, bool approved);
    
    event FeeGrowthUpdated(uint256 indexed id, uint256 feeGrowthX128, uint256 feeGrowthY128);
    event FeesSettled(address indexed account, uint256 indexed id, uint256 feesX, uint256 feesY);
    event PositionLocked(address indexed account, uint256 indexed id, uint256 lockUntil);
    event FeesCollected(address indexed account, uint256 indexed id, uint256 amountX, uint256 amountY);
    event RewardGrowthUpdated(uint256 indexed binId, uint256[] rewardGrowth);
    event RewardCollected(address indexed account, uint256 indexed binId, uint256 rewarderIndex, uint128 amount);

    struct BinFeeData {
        uint256 feeGrowthX128;           // Global fee growth for token X (Q128.128 format)
        uint256 feeGrowthY128;           // Global fee growth for token Y (Q128.128 format)
        uint256[] rewardGrowth128;       // Global reward growth per token (Q128.128 format) - array for multiple rewards
    }

    struct PositionFeeInfo {
        uint256 feeGrowthX128Last;       // Last recorded global fee growth X (Q128.128 format)
        uint256 feeGrowthY128Last;       // Last recorded global fee growth Y (Q128.128 format)
        uint256 tokensOwedX;             // Fees owed to this position for token X
        uint256 tokensOwedY;             // Fees owed to this position for token Y
        uint256[] rewardGrowth128Last;   // Last recorded global reward growth per token (Q128.128 format)
        uint256[] tokensOwedRewards;     // Rewards owed to this position per token
        uint256 lockUntil;               // Lock timestamp (0 = unlocked)
    }

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function totalSupply(uint256 id) external view returns (uint256);

    function balanceOf(address account, uint256 id) external view returns (uint256);

    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    function isApprovedForAll(address owner, address spender) external view returns (bool);

    function approveForAll(address spender, bool approved) external;

    function batchTransferFrom(address from, address to, uint256[] calldata ids, uint256[] calldata amounts) external;
    
    function getBinFeeData(uint256 id) external view returns (BinFeeData memory);
    
    function getPositionFeeInfo(address account, uint256 id) external view returns (PositionFeeInfo memory);
    
    function getPendingFee(address account, uint256 id) external view returns (uint128 pendingX, uint128 pendingY);
    
    function isPositionLocked(address account, uint256 id) external view returns (bool locked, uint256 until);
}