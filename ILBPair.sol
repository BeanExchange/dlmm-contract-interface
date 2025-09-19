// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Hooks} from "../libraries/Hooks.sol";
import {ILBFactory} from "./ILBFactory.sol";
import {ILBFlashLoanCallback} from "./ILBFlashLoanCallback.sol";
import {ILBToken} from "./ILBToken.sol";
import {ILBRewarder} from "./ILBRewarder.sol";
import {IDexLens} from "./IDexLens.sol";

interface ILBPair is ILBToken {

    struct PriceData {
        uint256 nativePriceUSD;      // Native token price in USD (18 decimals)
        uint256 tokenXPriceNative;    // TokenX price in Native token (18 decimals)
        uint256 tokenYPriceNative;    // TokenY price in Native token (18 decimals)
    }

    struct MintArrays {
        uint256[] ids;
        bytes32[] amounts;
        uint256[] liquidityMinted;
    }

    struct SwapState {
        bytes32 hooksParameters;
        bytes32 reserves;
        bytes32 protocolFees;
        bytes32 amountsLeft;
        bytes32 parameters;
        uint16 binStep;
        uint24 activeId;
        bool swapForY;
    }
        
    struct SwapMetrics {
        uint256 totalSwapLiquidity;
        uint256 iterations;
    }    

     // Updated events with PriceData
    event DepositedToBins(address indexed sender, address indexed to, uint256[] ids, bytes32[] amounts, PriceData priceData);

    event WithdrawnFromBins(address indexed sender, address indexed to, uint256[] ids, bytes32[] amounts, PriceData priceData);

    event CompositionFees(address indexed sender, uint24 id, bytes32 totalFees, bytes32 protocolFees, PriceData priceData);

    event CollectedProtocolFees(address indexed feeRecipient, bytes32 protocolFees, PriceData priceData);

    event Swap(
        address indexed sender,
        address indexed to,
        uint24 id,
        bytes32 amountsIn,
        bytes32 amountsOut,
        uint24 volatilityAccumulator,
        bytes32 totalFees,
        bytes32 protocolFees,
        PriceData priceData
    );
    
    // @todo Fee collection event
    event FeesCollectedFromPair(address indexed sender, address indexed recipient, uint128 totalX, uint128 totalY);
   
    event StaticFeeParametersSet(
        address indexed sender,
        uint16 baseFactor,
        uint16 filterPeriod,
        uint16 decayPeriod,
        uint16 reductionFactor,
        uint24 variableFeeControl,
        uint16 protocolShare,
        uint24 maxVolatilityAccumulator
    );

    event HooksParametersSet(address indexed sender, bytes32 hooksParameters);

    event FlashLoan(
        address indexed sender,
        ILBFlashLoanCallback indexed receiver,
        uint24 activeId,
        bytes32 amounts,
        bytes32 totalFees,
        bytes32 protocolFees,
        PriceData priceData
    );

    event OracleLengthIncreased(address indexed sender, uint16 oracleLength);

    event ForcedDecay(address indexed sender, uint24 idReference, uint24 volatilityReference);

    function initialize(
        uint16 baseFactor,
        uint16 filterPeriod,
        uint16 decayPeriod,
        uint16 reductionFactor,
        uint24 variableFeeControl,
        uint16 protocolShare,
        uint24 maxVolatilityAccumulator,
        uint24 activeId,
        IDexLens dexLens
    ) external;

    function setDexLens(IDexLens dexLens) external;

    function implementation() external view returns (address);

    function getFactory() external view returns (ILBFactory factory);

    function getTokenX() external view returns (IERC20 tokenX);

    function getTokenY() external view returns (IERC20 tokenY);

    function getBinStep() external view returns (uint16 binStep);

    function getReserves() external view returns (uint128 reserveX, uint128 reserveY);
    
    function getReservesAndFees() external view returns (
        uint128 reserveX, 
        uint128 reserveY, 
        uint128 feesX, 
        uint128 feesY
    );

    function getActiveId() external view returns (uint24 activeId);

    function getBin(uint24 id) external view returns (uint128 binReserveX, uint128 binReserveY);

    function getNextNonEmptyBin(bool swapForY, uint24 id) external view returns (uint24 nextId);

    function getProtocolFees() external view returns (uint128 protocolFeeX, uint128 protocolFeeY);

    function getStaticFeeParameters()
        external
        view
        returns (
            uint16 baseFactor,
            uint16 filterPeriod,
            uint16 decayPeriod,
            uint16 reductionFactor,
            uint24 variableFeeControl,
            uint16 protocolShare,
            uint24 maxVolatilityAccumulator
        );

    function getLBHooksParameters() external view returns (bytes32 hooksParameters);

    function getVariableFeeParameters()
        external
        view
        returns (uint24 volatilityAccumulator, uint24 volatilityReference, uint24 idReference, uint40 timeOfLastUpdate);

    function getOracleParameters()
        external
        view
        returns (uint8 sampleLifetime, uint16 size, uint16 activeSize, uint40 lastUpdated, uint40 firstTimestamp);

    function getOracleSampleAt(uint40 lookupTimestamp)
        external
        view
        returns (uint64 cumulativeId, uint64 cumulativeVolatility, uint64 cumulativeBinCrossed);

    function getPriceFromId(uint24 id) external view returns (uint256 price);

    function getIdFromPrice(uint256 price) external view returns (uint24 id);

    function getSwapIn(uint128 amountOut, bool swapForY)
        external
        view
        returns (uint128 amountIn, uint128 amountOutLeft, uint128 fee);

    function getSwapOut(uint128 amountIn, bool swapForY)
        external
        view
        returns (uint128 amountInLeft, uint128 amountOut, uint128 fee);

    function swap(bool swapForY, address to) external returns (bytes32 amountsOut);

    function flashLoan(ILBFlashLoanCallback receiver, bytes32 amounts, bytes calldata data) external;

    function mint(
        address to,
        bytes32[] calldata liquidityConfigs,
        address refundTo,
        uint256 lockUntil
    ) external returns (bytes32 amountsReceived, bytes32 amountsLeft, uint256[] memory liquidityMinted);

    function burn(address from, address to, uint256[] calldata ids, uint256[] calldata amountsToBurn)
        external
        returns (bytes32[] memory amounts);

    function collectProtocolFees() external returns (bytes32 collectedProtocolFees);
    
    function collectFees(uint256[] calldata ids, address account) 
        external 
        returns (uint128 totalX, uint128 totalY);
    
    function collectRewards(uint256[] calldata ids, address account)
        external
        returns (uint128[][] memory collectRewards_);
    
    function getPendingFees(uint256[] calldata ids, address account)
        external 
        view 
        returns (uint128[] memory feesX, uint128[] memory feesY);

    function getPendingRewards(uint256[] calldata ids, address account)
        external 
        view 
        returns (uint128[][] memory collectRewards_);

    function increaseOracleLength(uint16 newLength) external;

    function setStaticFeeParameters(
        uint16 baseFactor,
        uint16 filterPeriod,
        uint16 decayPeriod,
        uint16 reductionFactor,
        uint24 variableFeeControl,
        uint16 protocolShare,
        uint24 maxVolatilityAccumulator
    ) external;

    function setHooksParameters(bytes32 hooksParameters, bytes calldata onHooksSetData) external;

    function forceDecay() external;

    function addRewarder(address token) external;

    function updateEmissionRate(address token, uint256 newRate) external;

    function getRewardEmissions() external view returns (uint256[] memory emissions);

    function getInfoRewarder(uint256 index) external view returns (
        address rewardToken,
        uint256 emissionPerSecond
    );

    function depositVault(address token, uint256 amount) external;

    function initializeRewarder(address vault) external;
}