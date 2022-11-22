import { HardhatUserConfig, task } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-waffle";

const RECOVERY_PHRASE = "INSERT_YOUR_PRIVATE_KEY_HERE";

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

const config: HardhatUserConfig = {
  solidity: "0.7.0",

  networks: {
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",

      accounts: {
        mnemonic: RECOVERY_PHRASE,
      },
    },
  },
};

export default config;
