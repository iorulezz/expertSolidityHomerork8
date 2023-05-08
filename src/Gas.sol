// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract GasContract {
    address constant contractOwner = address(0x1234);
    uint constant supply = 4;

    event AddedToWhitelist(address userAddress, uint tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory, uint) payable {}

    function balanceOf(address) external pure returns (uint) {
        return supply;
    }

    function balances(address) external pure returns (uint) {
        return supply;
    }

    function transfer(address, uint, string calldata) external {}

    function addToWhitelist(address _userAddrs, uint256 __tier) external {
        assembly {
            if iszero(and(eq(caller(), 0x1234), lt(__tier, 255))) {
                revert(0, 0)
            }
            mstore(0, _userAddrs)
            mstore(32, __tier)
            log1(
                0,
                64,
                0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52
            )
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) external {
        assembly {
            log2(
                0,
                0,
                0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3,
                _recipient
            )
        }
    }

    function getPaymentStatus(address) external pure returns (bool, uint) {
        return (true, supply);
    }

    function whitelist(address) external pure returns (uint) {
        return supply;
    }

    function administrators(uint index) external pure returns (address result) {
        if (index == 0) {
            return 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2;
        } else if (index == 1) {
            return 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46;
        } else if (index == 2) {
            return 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf;
        } else if (index == 3) {
            return 0xeadb3d065f8d15cc05e92594523516aD36d1c834;
        }
        return contractOwner;
    }
}
