pragma solidity >=0.5.0;

import "./Owned.sol";

contract TokenList is Owned{
    mapping (address => uint) tokens;
    address[] tokenList;

    function addToken(address account) public onlyOwner{
        require(!isToken(account), "Token already on list");
        tokens[account] = tokenList.push(account) - 1;
        emit AddToken(account, false, block.timestamp);
    }

    function isToken(address account) private view returns (bool isIndeed){
        if(tokenList.length == 0) return false;
        return (account == tokenList[tokens[account]]);
    }

    function getAllTokens() public view onlyOwner returns (address[] memory){
        return tokenList;        
    }
    
    event AddToken(address indexed account, bool success, uint timestamp);
  
    
}