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


   function addAccount(address account) public onlyOwner{
      require(account != address(0));
      if (!existAccount(account)){
        mappingAccount[account]= AccountList(account,false,now);
        emit Account(account, false, now);
      }
     
    }

    function modifyPay(address account, bool success) public onlyOwner{
        mappingAccount[account].pay=success;
        emit Account(account, success, now);
        
    }


    function existAccount(address account) public view returns(bool success){
        if (mappingAccount[account].account == account){
          return true;
        }else{
          return false;
        }
        
    }

    function isPay(address account) public view returns(bool success){
        if( mappingAccount[account].pay==true) return true;
        return false;
    }

    /*********************MODIFICADORES*******************************************/
    modifier onlyOwner(){
        require (msg.sender == owner, "only owner can call this");
        _;
    }

    

   /********************EVENTOS*******************************************/
   event Account(address indexed account, bool pay, uint256 timestamp);


}