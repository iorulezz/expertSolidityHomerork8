// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract GasContract {
    uint256 private immutable totalSupply; // = 0; // cannot be updated
    mapping(address => uint256) public balances;
    address public contractOwner;
    mapping(address => uint8) public whitelist;
    address[] public administrators; // reconsider if removing 5 here makes it worse Ant0
    mapping(address => uint256) public whiteListStruct;

    event AddedToWhitelist(address userAddress, uint256 tier);

    //Ant0: Consider changing admin check with mapping. Then the constructor will be more expensive (loop for initialization)
    function checkForAdmin(address _user) public view returns (bool) {
        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (administrators[ii] == _user) {
                return true;
            }
        }
        return false;
    }

    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;
        administrators = _admins;
        balances[contractOwner] = totalSupply;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public returns (bool status_) {
        address senderOfTx = msg.sender;
        require(balances[senderOfTx] >= _amount);
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
        return true;
    }

    function addToWhitelist(address _userAddrs, uint256 _tier) public {
        address senderOfTx = msg.sender;
        require(senderOfTx == contractOwner || checkForAdmin(senderOfTx));
        require(_tier < 255);
        whitelist[_userAddrs] = uint8(_tier);
        if (_tier > 3) {
            whitelist[_userAddrs] = 3;
        }
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public {
        address senderOfTx = msg.sender;
        whiteListStruct[senderOfTx] = _amount;
        uint8 usersTier = whitelist[senderOfTx];
        balances[senderOfTx] -= _amount - usersTier;
        balances[_recipient] += _amount - usersTier;
        emit WhiteListTransfer(_recipient);
    }

    function getPaymentStatus(
        address sender
    ) external view returns (bool, uint256) {
        return (true, whiteListStruct[sender]);
    }
}
