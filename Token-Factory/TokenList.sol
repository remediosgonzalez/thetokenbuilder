pragma solidity >=0.5.0;

import "./Owned.sol";

contract TokenList is Owned{
    mapping (address => uint) tokens;
    //address[] tokenList;
    mapping(address => address) public tokenList;
    
    function addToken(address account) public onlyOwner{
        require(!isToken(account), "Token already on list");
        
        tokenList[account]=account;
        emit AddToken(account, false, block.timestamp);
    }

    function isToken(address account) private view returns (bool isIndeed){
        if(tokenList[account] == account) return true;
        return (false);
    }

    /*function getAllTokens() public view onlyOwner returns (address account){
        return tokenList;        
    }
    */
    event AddToken(address indexed account, bool success, uint256 timestamp);
  
    
}