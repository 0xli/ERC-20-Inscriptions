const Minter = artifacts.require("Minter");

module.exports = async function (deployer, network, accounts) {
    await deployer.deploy(Minter);
    const Instance = await Minter.deployed();
};