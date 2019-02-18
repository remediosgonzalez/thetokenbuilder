pragma solidity ^0.4.4;
import './ERC20Interface.sol';

contract FactoryToken is ERC20Interface{
    string public name;
    string public symbol;
    uint public decimals;
    uint public supply;
    address owner;
    
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
      
    function FactoryToken(){/*(string _name, string _symbol, uint _decimals, uint256 _totalSupply) public {
        name=_name;
        symbol=_symbol;
        decimals=_decimals;
        supply = _totalSupply;
        balances[msg.sender] = _totalSupply;*/
        owner = msg.sender;
    }
    
    function getName() public returns(string _name){
        return name;
    }
    
    function getSymbol() public returns(string){
        return symbol;
    }
    
    function getDecimals() public returns(uint){
        return decimals;
    }
    
    function getSupply() public returns(uint){
        return supply;
    }
    
    function balanceOf(address tokenOwner) public returns (uint balance){
        return balances[tokenOwner];
    }
    
    function createToken(string _name, string _symbol, uint _decimals, uint256 _totalSupply, address _from) public{
        name=_name;
        symbol=_symbol;
        decimals=_decimals;
        supply = _totalSupply;
        balances[_from] = _totalSupply;
    }
    
    function transfer(address to, uint tokens) public returns (bool success){
        //require(owner==msg.sender);
        balances[owner]-=tokens;
        balances[to]+=tokens;
        Transfer(owner, to, tokens);
        return true;
        
    }
    
    function allowance(address tokenOwner, address spender) public returns (uint remaining){
        
        return allowed[tokenOwner][spender];
    }
    
    function getAllowance(address spender)public returns(uint){
        return allowed[msg.sender][spender];
    }
    
    function approve(address spender, uint tokens) public returns (bool success){
        allowed[msg.sender][spender]=tokens;
        Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function getApprove(address spender)public returns(uint){
        return allowed[msg.sender][spender];
    }
    
    function transferFrom(address from, address to, uint tokens) public returns (bool success){
        balances[from]-= tokens;
        balances[to]+=tokens;
        Transfer(from, to, tokens);
        return true;
        
    }
    
    function totalSupply() public returns (uint){
        return supply;
    }
    //No aceptamos ether
    function () public payable {
        throw;
    }
}