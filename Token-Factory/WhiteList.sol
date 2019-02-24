pragma solidity ^0.5.0;

contract WhiteList{
  
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


   function addAccount(address account) public onlyOwner notExistAccount(account){
        require(account != address(0));
        mappingAccount[account]= AccountList(account,false,block.timestamp);
        emit Account(account, false, block.timestamp);
      
    }

    function modifyPay(address account, bool success) public onlyOwner onlyExistAccount(account){
        mappingAccount[account].pay=success;
        emit Account(account, success, block.timestamp);
        
    }

    function showAccount(address account) public view returns(address){
        return mappingAccount[account].account;
    }
    /*********************MODIFICADORES*******************************************/
    modifier onlyOwner(){
        require (msg.sender == owner, "only owner can call this");
        _;
    }

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
   event Account(address indexed account, bool pay, uint256 timestamp);


}