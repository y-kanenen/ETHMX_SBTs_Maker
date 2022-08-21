// run.js
const main = async () => {
    // コントラクトがコンパイルします
    // コントラクトを扱うために必要なファイルが `artifacts` ディレクトリの直下に生成されます。
    const nftContractFactory = await hre.ethers.getContractFactory("Web3Mint");
    // Hardhat がローカルの Ethereum ネットワークを作成します。
    const nftContract = await nftContractFactory.deploy();
    // コントラクトが Mint され、ローカルのブロックチェーンにデプロイされるまで待ちます。
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    let txn = await nftContract.mintIpfsNFT(
        "Umekichi",
        "bafybeibsxnjhat7ciez4ivuqbsilaxtrmp7qiv6xjlll7wqq7c4yqg3msq"
    );
    await txn.wait();
    let returnedTokenUri = await nftContract.tokenURI(0);
    console.log("tokenURI:",returnedTokenUri);

    txn = await nftContract.mintIpfsNFT(
        "Umekichi_2",
        "bafybeibsxnjhat7ciez4ivuqbsilaxtrmp7qiv6xjlll7wqq7c4yqg3msq"
    );
    await txn.wait();
    returnedTokenUri = await nftContract.tokenURI(1);
    console.log("tokenURI:",returnedTokenUri);

    txn = await nftContract.mintIpfsNFT(
        "Umekichi_3",
        "bafybeibsxnjhat7ciez4ivuqbsilaxtrmp7qiv6xjlll7wqq7c4yqg3msq"
    );
    await txn.wait();
    eturnedTokenUri = await nftContract.tokenURI(2);
    console.log("tokenURI:",returnedTokenUri);

    txn = await nftContract.mintIpfsNFT(
        "Umekichi_4",
        "bafybeibsxnjhat7ciez4ivuqbsilaxtrmp7qiv6xjlll7wqq7c4yqg3msq"
    );
    await txn.wait();
    returnedTokenUri = await nftContract.tokenURI(3);
    console.log("tokenURI:",returnedTokenUri);
  };
  // エラー処理を行っています。
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };

  runMain();