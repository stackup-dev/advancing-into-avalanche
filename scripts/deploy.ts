import { ethers } from "hardhat";

const main = async () => {
  const AuctionManager = await ethers.getContractFactory("AuctionManager"); // Auction Manager contract
  const auctionManager = await AuctionManager.deploy(); // Auction Manager contract instance
  await auctionManager.deployed(); // wait for contract to be deployed
  const auctionManagerAddress = await auctionManager.address; // Auction Manager contract address

  console.log(`Auction Manager deployed to: ${auctionManagerAddress}`); // Auction Manager contract address
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
