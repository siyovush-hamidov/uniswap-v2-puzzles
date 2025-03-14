// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IUniswapV2Pair.sol";
import "../lib/forge-std/src/interfaces/IERC20.sol";
import "../lib/forge-std/src/console.sol";

contract AddLiquid {
    /**
     *  ADD LIQUIDITY WITHOUT ROUTER EXERCISE
     *
     *  The contract has an initial balance of 1000 USDC and 1 WETH.
     *  Mint a position (deposit liquidity) in the pool USDC/WETH to msg.sender.
     *  The challenge is to provide the same ratio as the pool then call the mint function in the pool contract.
     *
     */
    function addLiquidity(
        address usdc,
        address weth,
        address pool,
        uint256 usdcReserve,
        uint256 wethReserve
    ) public {
        IUniswapV2Pair pair = IUniswapV2Pair(pool);

        // // Определяем, какой токен какой
        (address token0, address token1) = (pair.token0(), pair.token1());
        // // Определяем правильное соотношение ликвидности
        uint256 usdcBalance = IERC20(usdc).balanceOf(address(this));
        uint256 wethBalance = IERC20(weth).balanceOf(address(this));

        // Определяем правильное соотношение ликвидности
        uint256 amountWETH;
        uint256 amountUSDC;

        if (token0 == weth) {
            // WETH это token0
            amountWETH = wethBalance; // Используем весь WETH
            amountUSDC = (amountWETH * usdcReserve) / wethReserve; // Рассчитываем необходимое количество USDC

            if(amountUSDC > usdcBalance)
            {
                amountUSDC = usdcBalance;
                amountWETH = (amountUSDC * wethReserve) / usdcReserve;
            }
        } else {
            // USDC это token0
            amountUSDC = usdcBalance; // Используем весь USDC
            amountWETH = (amountUSDC * wethReserve) / usdcReserve; // Рассчитываем необходимое количество WETH

            if (amountWETH > wethBalance) {
                // Если у нас недостаточно WETH, уменьшаем количество USDC
                amountWETH = wethBalance;
                amountUSDC = (amountWETH * usdcReserve) / wethReserve;
            }
        }
        require(
            IERC20(usdc).transfer(pool, amountUSDC),
            "USDC transfer failed"
        );
        require(
            IERC20(weth).transfer(pool, amountWETH),
            "WETH transfer failed"
        );

        // // Вызываем mint, чтобы получить LP-токены
        pair.mint(msg.sender);
    }
}
