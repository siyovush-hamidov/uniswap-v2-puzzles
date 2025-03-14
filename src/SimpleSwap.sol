// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IERC20.sol";
import "../lib/forge-std/src/console.sol";

contract SimpleSwap {
    /**
     *  PERFORM A SIMPLE SWAP WITHOUT ROUTER EXERCISE
     *
     *  The contract has an initial balance of 1 WETH.
     *  The challenge is to swap any amount of WETH for USDC token using the `swap` function
     *  from USDC/WETH pool.
     *
     */
    function performSwap(address pool, address weth, address usdc) public {
        /**
         *     swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data);
         *
         *     amount0Out: the amount of USDC to receive from swap.
         *     amount1Out: the amount of WETH to receive from swap.
         *     to: recipient address to receive the USDC tokens.
         *     data: leave it empty.
         */

        // your code start here
        IUniswapV2Pair pair = IUniswapV2Pair(pool);
        (uint256 reserve0, uint256 reserve1, ) = pair.getReserves();

        (address token0, address token1) = (pair.token0(), pair.token1());
        bool wethIsToken0 = weth == token0;
        uint256 amountOut = 1000e6; // 1000 USDC

        require(amountOut < reserve0, "Not enough USDC in pool");
        require(IERC20(weth).transfer(pool, 1 ether), "WETH transfer failed");

        pair.swap(
            wethIsToken0 ? 0 : amountOut,
            wethIsToken0 ? amountOut : 0,
            address(this),
            bytes("")
        );
    }
}
