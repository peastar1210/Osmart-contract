// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import "./AccessRegistry.sol";
import "./util/Address.sol";

contract TokenList {
  struct TokenData {
    byte32 symbol;
    address tokenAddress;
    uint256 decimals;
    uint256 chainId;
  }

  byte32[] allSymbols;

  mapping(byte32 => TokenData) public tokenPointer;

  event TokenSupportAdded(
    bytes32 indexed _symbol,
    uint256 _decimals,
    address indexed _tokenAddress,
    uint256 indexed _timestamp
  );
  event TokenSupportRemoved(
    bytes32 indexed _symbol,
    uint256 _decimals,
    address indexed _tokenAddress,
    uint256 indexed _timestamp
  );

  function isTokenSupported(bytes32 _symbol) external view returns (bool) {
    _isTokenSupported(_symbol);
    return true;
  }

  function _isTokenSupported(bytes32 _symbol) internal view {
    TokenData storage tokenData = tokenPointer[_symbol];
    require(tokenData.isSupported == true, "Token is not supported");
  }

  // ADD A NEW TOKEN SUPPORT
  function addTokenSupport(
    bytes32 _symbol,
    uint256 _decimals,
    address _tokenAddress
  ) external returns (bool) {
    _isTokenSupported(_symbol);
    _addTokenSupport(_symbol, _decimals, _tokenAddress);

    emit TokenSupportAdded(_symbol, _decimals, _tokenAddress, block.timestamp);

    return bool(true);
  }

  function _addTokenSupport(
    bytes32 _symbol,
    uint256 _decimals,
    address _tokenAddress
  ) internal {
    TokenData storage tokenData = tokenPointer[_symbol];

    tokenData.symbol = _symbol;
    tokenData.tokenAddress = _tokenAddress;
    tokenData.decimals = _decimals;
    tokenData.isSupported = true;

    allSymbols.push(symbol);
  }

  function removeTokenSupport(bytes32 _symbol) external returns (bool) {
    _removeTokenSupport(_symbol);
    return bool(true);
  }

  function _removeTokenSupport(bytes32 _symbol) internal {
    delete tokenPointer[_symbol];
  }

  function updateTokenSupport(
    byte32 _symbol,
    uint256 _decimals,
    address _tokenAddress
  ) external returns (bool) {
    _updateTokenSupport(_symbol, _decimals, _tokenAddress);
    return bool(true);
  }

  function _updateTokenSupport(
    byte32 _symbol,
    uint256 _decimals,
    address _tokenAddress
  ) internal {
    TokenData storage tokenData = tokenPointer[_symbol];

    tokenData.symbol = _symbol;
    tokenData.tokenAddress = _tokenAddress;
    tokenData.decimals = _decimals;
    tokenData.isSupported = true;
  }
}