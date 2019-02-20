pragma solidity ^0.4.24;
import './ERC20Interface.sol';
import './Token.sol';

contract FactoryToken is ERC20Interface,Token{
    /*string public name;
    string public symbol;
    uint public decimals;
    uint public supply;*/
    address owner;
    
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
      
    constructor() public{/*(string _name, string _symbol, uint _decimals, uint256 _totalSupply) public {        
        owner = msg.sender;
    }
    
    //Faltaría implmentar quien puede crear tokens (contract AddressList)
    function newToken(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply, address _from) public returns(bool success){
        Token.createToken(_name, _symbol, _decimals, _totalSupply, _from);    
        return true;
    }
    
    function transfer(address to, uint tokens) public returns (bool success){
        balances[to]+=tokens;
        return true;
        
    }
    
   function _transfer(address from, address to, uint tokens) public returns (bool success){
        //require(owner==msg.sender);
        Token.personalToken[from].balances[from]-=tokens;
        transfer(to,tokens);
        emit Transfer(from, to, tokens);
        return true;
        
    }
    
    function allowance(address tokenOwner, address spender) public returns (uint remaining){
        
        return allowed[tokenOwner][spender];
    }
    
    function getAllowance(address spender)public view returns(uint){
        return allowed[msg.sender][spender];
    }
    
    function approve(address spender, uint tokens) public returns (bool success){
        allowed[msg.sender][spender]=tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function getApprove(address spender)public view returns(uint){
        return allowed[msg.sender][spender];
    }
    
    function transferFrom(address from, address to, uint tokens) public  returns (bool success){
        Token.personalToken[from].balances[from]-= tokens;
        balances[to]+=tokens;
        emit Transfer(from, to, tokens);
        return true;
        
    }
    
     modifier onlyPersonalOwner(address account){
        require(Token.personalToken[account].owner==msg.sender);
        _;
    }
    
    function totalSupply() public returns (uint){
        return supply;
    }
    //No aceptamos ether
    function () public payable {
        revert();
    }
    
    function getName(address account) public view returns(string _name){
        return Token.personalToken[account].name;
    }
    
    function getSymbol(address account) public view returns(string){
        return Token.personalToken[account].symbol;
    }
    
    function getDecimals(address account) public view returns(uint){
        return Token.personalToken[account].decimals;
    }
    
    function getSupply(address account) public view returns(uint){
        return Token.personalToken[account].supply;
    }
    
    function balanceOf(address account) public returns (uint balance){
        return Token.personalToken[account].balances[account];
    }
}
