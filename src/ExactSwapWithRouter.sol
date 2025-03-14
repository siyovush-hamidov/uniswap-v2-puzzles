// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IERC20.sol";

contract ExactSwapWithRouter {
    /**
     *  PERFORM AN EXACT SWAP WITH ROUTER EXERCISE
     *
     *  The contract has an initial balance of 1 WETH.
     *  The challenge is to swap an exact amount of WETH for 1337 USDC token using UniswapV2 router.
     *
     */
    address public immutable router;

    constructor(address _router) {
        router = _router;
    }

    function performExactSwapWithRouter(
        address weth,
        address usdc,
        uint256 deadline
    ) public {
        // Создаем путь обмена: WETH -> USDC
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = usdc;

        // Определяем, сколько нам нужно WETH для получения 1337 USDC
        uint256[] memory amountsIn = IUniswapV2Router(router).getAmountsIn(
            1337e6,
            path
        );
        uint256 wethAmountIn = amountsIn[0];

        // Одобряем router на использование наших WETH
        IERC20(weth).approve(router, wethAmountIn);

        // Выполняем обмен
        IUniswapV2Router(router).swapExactTokensForTokens(
            wethAmountIn,
            1337e6, // Минимальное количество USDC, которое мы хотим получить
            path,
            address(this), // Получаем USDC на этот контракт
            deadline
        );
    }
}

interface IUniswapV2Router {
    /**
     *     amountIn: the amount of input tokens to swap.
     *     amountOutMin: the minimum amount of output tokens that must be received for the transaction not to revert.
     *     path: an array of token addresses. In our case, WETH and USDC.
     *     to: recipient address to receive the liquidity tokens.
     *     deadline: timestamp after which the transaction will revert.
     */
    function getAmountsIn(
        uint amountOut,
        address[] calldata path
    ) external view returns (uint[] memory amounts);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}
