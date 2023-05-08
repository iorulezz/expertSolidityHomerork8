// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract GasContract {
    address private sender;
    uint256 private amount;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed recipient);

    constructor(address[] memory, uint256) {}

    function balanceOf(address) external pure returns (uint256) {
        return 4;
    }

    function balances(address _user) external view returns (uint256 result) {
        assembly {
            let _sender := sload(0)
            if iszero(eq(_sender, _user)) {
                result := sload(1)
            }
        }
    }

    function transfer(address, uint256 _amount, string calldata) external {
        amount = _amount;
    }

    function addToWhitelist(address _userAddrs, uint256 __tier) external {
        assembly {
            if iszero(and(eq(caller(), 0x1234), lt(__tier, 255))) {
                revert(0, 0)
            }
            mstore(0, _userAddrs)
            mstore(32, __tier)
            log1(0, 64, 0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52)
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) external {
        assembly {
            sstore(0, caller())
            sstore(1, _amount)
            log2(0, 0, 0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3, _recipient)
        }
    }

    function getPaymentStatus(address) external view returns (bool, uint256) {
        return (true, amount);
    }

    function whitelist(address) external pure returns (uint256) {
        return 0;
    }

    function administrators(
        uint8 index
    ) external pure returns (address result) {
        assembly {
            switch index
            case 0 {
                result := 0x3243Ed9fdCDE2345890DDEAf6b083CA4cF0F68f2
            }
            case 1 {
                result := 0x2b263f55Bf2125159Ce8Ec2Bb575C649f822ab46
            }
            case 2 {
                result := 0x0eD94Bc8435F3189966a49Ca1358a55d871FC3Bf
            }
            case 3 {
                result := 0xeadb3d065f8d15cc05e92594523516aD36d1c834
            }
            default {
                result := 0x1234
            }
        }
    }
}
