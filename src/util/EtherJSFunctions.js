import { ethers } from "ethers";
import abi from "../abi.json";

export async function connectToWallet() {
  // Paste Step 5 code here
}

export async function getContract(signer) {
  // Paste Step 6 code here
}

export async function mintNFT(stringURI, contract) {
  // Paste Step 7 code here
}

export function configureTokenURI(imageURL, name, description) {
  return JSON.stringify({
    name,
    description,
    image: imageURL,
    attributes: [],
  });
}
