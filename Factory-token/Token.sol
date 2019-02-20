pragma solidity ^0.4.24;

contract Token {
    
    address owner;
    
    struct PersonalToken{
        string name;
        string symbol;
        uint8 decimals;
        uint256 supply;
        mapping(address => uint) balances;
        address owner;//Propietario del token con permisos para mover los tokens
        address connectorContract;//Para conectar con un contrato que puede realizar operaciones sobre el token
    }
    
    mapping (address=> PersonalToken) personalToken;
    PersonalToken[] arrayPersonalToken;
    
    constructor()public {
        owner = msg.sender;
    }
    
    function createToken(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply, address account) internal{
        
        personalToken[account]=PersonalToken(_name, _symbol, _decimals, _totalSupply, account, account);
        personalToken[account].balances[account] = _totalSupply;
        arrayPersonalToken.push(personalToken[account]);
        emit CreateToken(_name,_symbol,_decimals,_totalSupply,account);
        
    }
    
    function getPersonalToken(address account) internal view
    returns (string _name,
             string _symbol,
             uint8 _decimals,
             uint256 _supply,
             //mapping(address => uint) balances, 
             address _owner,
             address _connectorContract){
        PersonalToken memory pt = personalToken[account];
        return (pt.name, pt.symbol, pt.decimals,pt.supply,pt.owner, pt.connectorContract);
    }
    
    function getBalance(address account) public view returns(uint){
        return personalToken[account].balances[account];
        
    }
    
    event CreateToken(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply, address account);   
}
