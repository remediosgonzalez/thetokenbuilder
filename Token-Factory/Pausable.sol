pragma solidity >=0.5.0;

import "./Owned.sol";


/**
 * @title Pausable
 * @dev Implementamos mecanismos de emergencia
 */
contract Pausable is Owned {
  event Pause();
  event Unpause();

  bool public paused = false;


  /**
   * @dev Modificador para acceder a una función si no está en pausa.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modificador para entrar en una función sólo si está en pausa
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev Función que solo el propietario puede ejecutar para parar un contrato
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  /**
   * @dev Función para pausar un contrato sólo permitido al propietario
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }
}