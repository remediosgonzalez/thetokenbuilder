pragma solidity >=0.5.0;

import "./Owned.sol";

contract TokenList is Owned{
    mapping (address => uint) tokens;
    address[] tokenList;

    function addToken(address token) public onlyOwner{
        //require(!isToken(token), "Token already on list");
        tokens[token] = tokenList.push(token) - 1;
    }

    function isToken(address token) private view returns (bool isIndeed){
        if(tokenList.length == 0) return false;
        return (token == tokenList[tokens[token]]);
    }

    function getAllTokens() public view onlyOwner returns (address[] memory){
        return tokenList;        
    }
}