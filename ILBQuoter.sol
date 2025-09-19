// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title ILBQuoter Interface
 * @notice Interface for the Liquidity Book Quoter
 * @dev Helper contract to determine best path through multiple markets
 */
interface ILBQuoter {
    /**
     * @dev The quote struct returned by the quoter
     * @param route address array of the token to go through
     * @param pairs address array of the pairs to go through
     * @param binSteps The bin step to use for each pair
     * @param amounts The amounts of every step of the swap
     * @param virtualAmountsWithoutSlippage The virtual amounts of every step of the swap without slippage
     * @param fees The fees to pay for every step of the swap
     */
    struct Quote {
        address[] route;
        address[] pairs;
        uint256[] binSteps;
        uint128[] amounts;
        uint128[] virtualAmountsWithoutSlippage;
        uint128[] fees;
    }

    /**
     * @notice Returns the Dex factory address
     * @return factory Dex factory address
     */
    function getFactory() external view returns (address factory);

    /**
     * @notice Returns the Dex router address
     * @return router Dex router address
     */
    function getRouter() external view returns (address router);

    /**
     * @notice Finds the best path given a list of tokens and the input amount wanted from the swap
     * @param route List of the tokens to go through
     * @param amountIn Swap amount in
     * @return quote The Quote structure containing the necessary element to perform the swap
     */
    function findBestPathFromAmountIn(address[] calldata route, uint128 amountIn)
        external
        view
        returns (Quote memory quote);

    /**
     * @notice Finds the best path given a list of tokens and the output amount wanted from the swap
     * @param route List of the tokens to go through
     * @param amountOut Swap amount out
     * @return quote The Quote structure containing the necessary element to perform the swap
     */
    function findBestPathFromAmountOut(address[] calldata route, uint128 amountOut)
        external
        view
        returns (Quote memory quote);
}