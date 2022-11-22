import hre from "hardhat";

async function main() {
  const ButterflyToken = await hre.ethers.getContractFactory("ButterflyToken");
  const butterflyToken = await ButterflyToken.deploy();

  await butterflyToken.deployed();

  console.log("ButterflyToken deployed to:", butterflyToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
