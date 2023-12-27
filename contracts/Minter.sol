// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "./EthrunesProtocol.sol";


contract Minter is Ownable, EthrunesProtocol, Pausable {

    string  public _inscription = 'data:,{"p":"erc-20","op":"mint","tick":"bgle","amt":"1000"}';
    uint256 public constant FEE = 0.001 ether;
    uint256 public constant MAX_COUNT = 210000000;
    uint256 public counter = 0;

    constructor () Ownable(_msgSender()) {
    }

    receive() external payable whenNotPaused {
        require(msg.value >= FEE, "Minter: fee not enough");
        require(counter < MAX_COUNT, "Minter: max count reached");
        mint();
    }

    function setInscription(string memory inscription) public onlyOwner {
        _inscription = inscription;
    }

    function mint() private {
        emit ethrunes_protocol_Inscribe(msg.sender, _inscription);
        counter++;
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
