// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    mapping(address => uint256) public balances;
    mapping(address => uint8) public whitelist;
    mapping(address => uint256) private whiteListStruct;
    address private immutable contractOwner;
    address[5] public administrators;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        for (uint8 i = 0; i < 5; ) {
            address _admin = _admins[i];
            administrators[i] = _admin;
            unchecked {
                ++i;
            }
        }
        balances[msg.sender] = _totalSupply;
    }

    function balanceOf(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) external {
        unchecked {
            balances[msg.sender] -= _amount;
            balances[_recipient] += _amount;
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) external {
        require(msg.sender == contractOwner);
        require(_tier < 255);
        whitelist[_userAddrs] = 3;
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(address _recipient, uint256 _amount) external {
        whiteListStruct[msg.sender] = _amount;
        uint8 usersTier = whitelist[msg.sender];
        unchecked {
            balances[msg.sender] -= _amount - usersTier;
            balances[_recipient] += _amount - usersTier;
        }
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(
        address sender
    ) external view returns (bool, uint256) {
        return (true, whiteListStruct[sender]);
    }
}
