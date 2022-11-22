# Avalanche Quest 10 Project

This project demonstrates a basic Hardhat use case.
Deploying an Auction manager SC using metamask wallet to Avax Fuji Testnet

Install the necesary packages by running:

```shell
npm install
```

In `hardhat.config.ts` line 3, replace it with your Metamask wallet private key.

Compile your contracts by running:

```shell
npx hardhat compile
```

Deploy your contracts by running:

```shell
npx hardhat run scripts/deploy.ts --network fuji
```
