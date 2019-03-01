pragma solidity >=0.5.0;
import "./Owned.sol";
import "./SafeMath.sol";
import './Burnable.sol';
import './Pausable.sol';

contract TokenERC20 is Owned, Burnable, Pausable {
    using SafeMath for uint256;
     
    address owner;
 
    string name;
    string symbol;
    uint256 decimals;
    uint256 supply;
    address connectorContract;
    
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint)) allowed;
    
   
    constructor(string memory _name, string memory _symbol, uint256 _decimals, uint256 _supply, address account) public {
        owner = account;
        name = _name;
        symbol=_symbol;
        decimals=_decimals;
        supply=_supply;
        balances[account]=supply;
        
    }
    
    function totalSupply() public view returns (uint){
        return supply;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining){
        return allowed[tokenOwner][spender];
    }
    
    function transfer(address to, uint tokens) public whenNotPaused returns (bool success){
        _transfer(msg.sender,to,tokens);
        return true;
        
    }
   
   function approve(address spender, uint tokens) public returns (bool success){
        allowed[msg.sender][spender]=tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    } 
    
    function transferFrom(address from, address to, uint tokens) public whenNotPaused returns (bool success){
        require(allowed[from][msg.sender]>=tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        emit Transfer(from, to, tokens);
        return true;
        
    }
    
    function Mutex() public payable { }
    
   function _transfer(address from, address to, uint tokens) private returns (bool success){
        require(to != address(0)); 
        require(balances[from] >= tokens); 
        require(balances[to].add(tokens) >= balances[to]);

        // Salvamos de manera temporal por si hay que deshacer la operacion
        uint previousBalances = balances[from].add(balances[to]);

        balances[from] = balances[from].sub(tokens);
        balances[to]  = balances[to].add(tokens);

        emit Transfer(from, to, tokens);

        //Controlamos de que todo ha ido bien
        assert(balances[from].add(balances[to]) == previousBalances);
       
        return true;
        
    }
    
    function newOwner (address account)public{
        transferOwnership(account);
    }
    
    function getAllowance(address spender)public view returns(uint){
        return allowed[msg.sender][spender];
    }
     
    function getApprove(address spender)public view returns(uint){
        return allowed[msg.sender][spender];
    }

    /*
     * Quema de tokens
     */

     function burn(uint _value) public whenNotPaused returns (bool success) {
        _burnTokens(msg.sender,_value);
        return true;
    }

    function _burnTokens(address from, uint _value) internal {
        require(balances[from] >= _value);              //Chequeamos que tenga la cantidad a quemar
        balances[from] = balances[from].sub(_value);    // Extraemos del sender la cantidad a quemar
        supply = supply.sub(_value);        // Actualizamos el supply
        emit  Burned(from, _value);
    }

    
   /*function getBalance(address account) public view returns(uint){
        return personalToken[account].balances[account];
        
    }*/
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
   
}