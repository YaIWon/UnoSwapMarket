const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("deploys the contracts successfully",  () => {
  let UnoSwapMarket, market, NFT ,nft, UnoSwapApprove, approve

  beforeEach(async() => {
     [owner,one, two,three, four, five,six,seven, eight, nine, ten] = await ethers.getSigners();
     UnoSwapMarket = await ethers.getContractFactory("UnoSwapMarket");
     market = await UnoSwapMarket.deploy();
     NFT  = await ethers.getContractFactory("NFT")
     nft = await NFT.connect(five).deploy(market.address);

  });
  describe("it can create and inherit outsider token", () => {
    it("can incrementId", async() => {


      const price = ethers.utils.parseUnits('100', 'ether')
      // await market.connect(one).createToken(market.address,"https://thisIstoken1", price,  true, true);
      //await nft.connect(three).mintTokens("https://outsidertoken")
      // await outsidertoken.connect(two).createToken(1,nft.address,"https://thisIstoken2", price,  true, true);
      await market.connect(one).createToken(0, market.address,"https://UnoSwapMarkettoken1",price, true, true)
      await market.connect(two).createToken(0, market.address,"https://outsiderToken1",price, true, true)
      //await approve.connect(one).setApproved(market.address,1);
      //await market.connect(one).setApproved(three.address)
      //await market.connect(three).createToken(1, nft.address,"https://outsiderToken1",price, true, true)
      await market.connect(one).swapToken(2,1);
      console.log("approved", await market.isApprovedForAll(two.address, market.address))
      //console.log("NFTapproved", await nft.getApproved(1))


      console.log("address one",one.address);
      //console.log("address two",two.address);

      items = await market.allTokens()
      items = await Promise.all(items.map(async i => {


        let item = {
          itemId: i.itemId.toString(),
          tokenId: i.tokenId.toString(),
          nftContract: i.tokenAddress,
          tokenUri: i.URI,
          seller: i.currentSeller,
          owner: i.currentOwner,
          price: i.price.toString(),
          listForSwap: i.listForSwap,
          anySwapAvailable: i.anySwapAvailable,
          swapped: i.swapped,

        }
        return item
      }))

        console.log('items: ', items)
      console.log("currentItems", await market._itemsIds())

    })
  })
});
