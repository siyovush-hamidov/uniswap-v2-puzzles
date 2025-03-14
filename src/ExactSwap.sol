// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IUniswapV2Pair.sol";
import "./interfaces/IERC20.sol";

contract ExactSwap {
    /**
     *  PERFORM AN SIMPLE SWAP WITHOUT ROUTER EXERCISE
     *
     *  The contract has an initial balance of 1 WETH.
     *  The challenge is to swap an exact amount of WETH for 1337 USDC token using the `swap` function
     *  from USDC/WETH pool.
     *
     */
    function performExactSwap(address pool, address weth, address usdc) public {
        /**
         *     swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data);
         *
         *     amount0Out: the amount of USDC to receive from swap.
         *     amount1Out: the amount of WETH to receive from swap.
         *     to: recipient address to receive the USDC tokens.
         *     data: leave it empty.
         */
        // IERC20(weth).
        IERC20(weth).approve(pool, type(uint256).max);
        IERC20(usdc).approve(pool, type(uint256).max);
        IUniswapV2Pair(pool).swap(
            1337e6,
            0,
            address(this),
            abi.encode("notEmpty")
        );
        // IUniswapV2Pair(pool).
        // your code start here
    }

    function uniswapV2Call(
        address sender,
        uint amount0Out,
        uint amount1Out,
        bytes calldata data
    ) public {
        (uint112 reserve0, uint112 reserve1, ) = IUniswapV2Pair(
            0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc
        ).getReserves();
        uint256 numerator = reserve1 * amount0Out * 1000;
        uint256 denominator = (reserve0 - amount0Out) * 997;
        uint256 amountIn = (numerator / denominator) + 1;
        
        IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2).transfer(
            address(0xB4e16d0168e52d35CaCD2c6185b44281Ec28C9Dc),
            amountIn
        );
    }
}
