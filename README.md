# **🔗 Uniswap V2 Puzzles by [RareSkills](https://www.rareskills.io)**  

## **📝 Overview**  
This repository contains Solidity challenges designed to **deepen your understanding of Uniswap V2 mechanics**. These puzzles cover liquidity pools, swaps, TWAP calculations, token rebasing, and attack vectors in DeFi.  

## **🚀 How to Play**  
1. **Clone the repository** 📂  
   ```shell
   git clone <repo-url>
   cd uniswap-v2-puzzles
   ```
2. **Install dependencies** ⚙️  
   ```shell
   forge install
   ```
3. **Start hacking** 🏴‍☠️  

## **✅ Running Tests**  
The tests **fork mainnet** to provide a realistic environment by interacting with real Uniswap V2 contracts. Get a Mainnet RPC URL from [Alchemy](https://alchemy.com) or [Infura](https://infura.io).  
Run a specific test:  
```shell
forge test --fork-url <your_mainnet_rpc_url> --match-path test/<test_filename>
```

### **🔍 Test Your RPC with HelloWorld Puzzle**  
Run the following command:  
```shell
forge test --fork-url <your_mainnet_rpc_url> --match-path test/HelloWorld.t.sol
```
If the test passes, your RPC is working. If it fails, your RPC may have **exceeded rate limits** or **contains a typo**.  

## **📚 Suggested Puzzle Order**  
- [HelloWorld](src/HelloWorld.sol) - 🔰 Intro to Uniswap pools  
- [AddLiquid](src/AddLiquid.sol) - 🏦 Manually adding liquidity  
- [AddLiquidWithRouter](src/AddLiquidWithRouter.sol) - 🔄 Adding liquidity via router  
- [BurnLiquid](src/BurnLiquid.sol) - ♻️ Removing liquidity manually  
- [BurnLiquidWithRouter](src/BurnLiquidWithRouter.sol) - 🔥 Removing liquidity via router  
- [SimpleSwap](src/SimpleSwap.sol) - 🔀 Basic token swap  
- [SimpleSwapWithRouter](src/SimpleSwapWithRouter.sol) - 🔄 Swap using router  
- [SandwichSwap](src/SandwichSwap.sol) - 🥪 Simulating MEV sandwich attacks  
- [MyMevBot](src/MyMevBot.sol) - 🤖 Building an MEV bot  
- [SyncAndSkim](src/SyncAndSkim.sol) - 🔍 Pool balance manipulation  
- [ExactSwap](src/ExactSwap.sol) - 🎯 Exact amount swap  
- [ExactSwapWithRouter](src/ExactSwapWithRouter.sol) - 🔄 Exact amount swap via router  
- [MultiHop](src/MultiHop.sol) - 🚀 Multi-hop swaps  
- [Twap](src/Twap.sol) - ⏳ Time-Weighted Average Price  

## **🎯 Who Should Try This?**  
- 🏗️ Solidity developers  
- 🔍 Smart contract auditors  
- 🛡️ DeFi security researchers  

## **📜 License**  
MIT License.