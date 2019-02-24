pragma solidity ^0.5.0;
import './Owned.sol';

contract WhiteList is Owned{
  
    address public owner;

    struct AccountList{
        address account;
        bool pay; 
        uint256 timestamp;
    }

    mapping(address=>AccountList) mappingAccount;
    
    constructor() public{
      owner = msg.sender;
    }   

    /* Alta de cuentas que se han registrado*/
   function addAccount(address account) public onlyOwner notExistAccount(account){
        require(account != address(0));
        mappingAccount[account]= AccountList(account,false,block.timestamp);
        emit AddAccount(account, false, block.timestamp);
      
    }
    /* Cuando realizan el pago hay que marcarlo a true para que le deje generar su token*/
    function modifyPay(address account, bool success) public onlyOwner onlyExistAccount(account){
        mappingAccount[account].pay=success;
        emit ModifyPay(account, success, block.timestamp);
        
    }
    
    function showAccount(address account) public view returns(address){
        return mappingAccount[account].account;
    }
    /*********************MODIFICADORES*******************************************/
    

    modifier onlyExistAccount(address account){
        require(mappingAccount[account].account==account);
        _;
    }
    
    modifier notExistAccount(address account){
        require(mappingAccount[account].account != account);
        _;
    }
        
    modifier onlyPay(address account){
        require(mappingAccount[account].pay);
        _;
    }
   /********************EVENTOS*******************************************/
   event AddAccount(address indexed account, bool pay, uint256 timestamp);
   event ModifyPay(address indexed account, bool pay, uint256 timestamp);


}