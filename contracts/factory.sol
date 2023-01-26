//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./erc721_mintable.sol";
import "./erc721AUriStorage.sol";

contract PikassoFactory is Ownable {
    mapping(address => ERC721Mintable) public _erc721Mintables;
    mapping(address => ERC721AURIStorage) public _erc721AURIStorages;
    string public name;

    constructor(string memory name_) {
        name = name_;
    }

    function deployErc721(address[] calldata collections) public onlyOwner {
        uint256 collectionLength = collections.length;
        require(collectionLength > 0, "have not any collection address");

        for (uint256 index; index < collectionLength; index++) {
            _erc721Mintables[collections[index]] = new ERC721Mintable(
                "Pikasso",
                "PKN"
            );

            _erc721Mintables[collections[index]].transferOwnership(
                collections[index]
            );
        }
    }


 function deployErc721A(address[] calldata collections) public onlyOwner {
        uint256 collectionLength = collections.length;
        require(collectionLength > 0, "have not any collection address");

        for (uint256 index; index < collectionLength; index++) {
            _erc721AURIStorages[collections[index]] = new ERC721AURIStorage(
                "Pikasso",
                "PKN"
            );

            _erc721AURIStorages[collections[index]].transferOwnership(
                collections[index]
            );
        }
    }
    function getErc721ContractAddress(address[] calldata collections)
        public
        view
        returns (address[] memory)
    {
        uint256 length = collections.length;

        address[] memory erc721 = new address[](length);
        for (uint256 index; index < length; index++) {
            erc721[index] = address(_erc721Mintables[collections[index]]);
        }

        return erc721;
    }

     function getErc721AContractAddress(address[] calldata collections)
        public
        view
        returns (address[] memory)
    {
        uint256 length = collections.length;

        address[] memory erc721A = new address[](length);
        for (uint256 index; index < length; index++) {
            erc721A[index] = address(_erc721AURIStorages[collections[index]]);
        }

        return erc721A;
    }
}
