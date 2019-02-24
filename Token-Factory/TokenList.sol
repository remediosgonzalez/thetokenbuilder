pragma solidity >=0.5.0;

import "./Owned.sol";

contract TokenList is Owned{
    mapping (address => uint) tokens;
    address[] tokenList;
    //mapping(address => address) public tokenList;
    
    function addToken(address account) internal onlyOwner{
        require(existAddressToken(account), "Token already on list");
        tokens[account] = tokenList.push(account) - 1;
        emit AddToken(account, false, block.timestamp);
    }

    function existAddressToken(address account) public view returns (bool isIndeed){
        if(tokenList.length == 0) return false;
        return (account == tokenList[tokens[account]]);
    }

    function getAllTokens() public view onlyOwner returns (address[] memory){
        return tokenList;        
    }
    
    event AddToken(address indexed account, bool success, uint256 timestamp);
  
    
}