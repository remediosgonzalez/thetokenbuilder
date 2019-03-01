pragma solidity >=0.5.0;

contract Owned{

    address public owner;

    constructor() public{
        owner = msg.sender;
    }   


   /**
   * @dev Permite que el propietario actual pueda transmitir el control a un nuevo propietario.
   * @param newOwner dirección del nuevo propietario.
   */
   function transferOwnership(address newOwner) public onlyOwner {
      require(newOwner != address(0));
      emit OwnershipTransferred(owner, newOwner);
      owner = newOwner;
    }


    /*********************MODIFICADORES*******************************************/
    modifier onlyOwner(){
        require (msg.sender == owner, "only owner can call this");
        _;
    }

    
    /********************EVENTOS*******************************************/
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



}