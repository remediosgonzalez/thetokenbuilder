pragma solidity >=0.5.0;

// Interface for burning tokens
contract Burnable {
  // @dev Destruir tokens de una cuenta
  // @param account cuenta a destruir
  // @param value cantidad de tokens a destruir
  function _burnTokens(address account, uint value) internal;
  event Burned(address account, uint value);
}
