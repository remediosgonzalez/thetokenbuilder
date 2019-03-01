pragma solidity >=0.5.0;
import './TokenERC20.sol';
import './TokenList.sol';

import "./WhiteList.sol";

contract TokenFactory is WhiteList, TokenList{

    address public owner;
    
    TokenList tokenList;
    TokenERC20 tokenERC20;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    mapping (address => address[]) public tokens;
    
    
    constructor () public {
        owner = msg.sender;
        tokenList = new TokenList();
    }

    
    function createToken(string memory name, string memory symbol, uint256 decimals, uint256 totalSupply, address account) public onlyExistAccount(account) onlyPay(account){
        tokenERC20 = new TokenERC20(name, symbol, decimals, totalSupply, account);
        //tokens[account]=address(tokenERC20)[];
        modifyPay(account,false);
        addToken(address(tokenERC20));        
        emit CreateToken(name,symbol,decimals,totalSupply,account);
        
    }

    /** 
    Devuelve la lista completa de direcciones de tokens creados
    */
    function getAllTokens() public view onlyOwner returns (address[] memory addressList){
        addressList = getAllTokens();
    }

    event CreateToken(string _name, string _symbol, uint256 _decimals, uint256 _totalSupply, address account);   
}
