// SPDX-License-Identifier: MIT
// From https://github.com/z0r0z/zolidity and https://github.com/z0r0z/wei-names

pragma solidity ^0.8.30;


/*
  ENSIP-10-compliant ENS resolvers MAY implement the following function interface:

interface ExtendedResolver {
    function resolve(bytes calldata name, bytes calldata data) external view returns(bytes);
}
*/

/// @dev represent the WNS resolver
interface IWNS {
    function resolve(uint256 tokenId) external view returns (address);
}

  /// @notice ENSIP-10 wildcard resolver: *.fromwei.eth -> <label>.wei via Wei Name Service.
contract FromWNSResolver {
    IWNS internal constant WNS = IWNS(0x0000000000696760E15f265e828DB644A0c242EB);

    /// @dev namehash("wei");
    bytes32 internal constant WEI_NODE = 0xa82820059d5df798546bcc2985157a77c3eef25eba9ba01899927333efacbd6f;  // `cast namehash wei`

    function resolve(bytes calldata name, bytes calldata data) external view returns (bytes memory) {

        /* will be used by this sort of pseudocode in clients:
           const supportsENSIP10 = resolver.supportsInterface('0x9061b923');
           if(supportsENSIP10) {
           const calldata = resolver[func].encodeFunctionCall(namehash(name), ...args);
           const result = resolver.resolve(dnsencode(name), calldata);
           return resolver[func].decodeReturnData(result);
        */

        bytes32 node = _weiNode(name, 0); // namehash of <prefix>.wei
        address a = WNS.resolve(uint256(node));

        bytes4 selector = bytes4(data[:4]);
        if (selector == 0x3b3b57de) return abi.encode(a); // addr(bytes32)
        if (selector == 0xf1cb7e06) {
            // addr(bytes32,uint256) — answer only ETH (coinType 60)
            (, uint256 coinType) = abi.decode(data[4:], (bytes32, uint256));
            if (coinType == 60) return abi.encode(abi.encodePacked(a));
        }
        return ""; // text/contenthash/other: no record
    }

    /// @dev EIP-137 namehash of DNS-encoded `name`, but with its fixed
    ///      ".fromwei.eth" parent swapped for ".wei". Recurses to the parent,
    ///      then folds each prefix label back in on the way out.
    function _weiNode(bytes calldata name, uint256 i) internal pure returns (bytes32) {
        // 13 == len(\x07fromwei\x03eth\x00); when only the parent remains, base = namehash("wei")
        if (name.length - i == 13) return WEI_NODE;
        uint256 len = uint8(name[i]);
        bytes32 labelHash = keccak256(name[i + 1:i + 1 + len]);
        return keccak256(abi.encodePacked(_weiNode(name, i + 1 + len), labelHash));
    }

    // @dev ERC-165: IExtendedResolver (0x9061b923) + ERC-165 (0x01ffc9a7).
    function supportsInterface(bytes4 id) external pure returns (bool) {
        // If a resolver implements [resolve(..)], it MUST return true when supportsInterface() is called on it with the interface's ID, 0x9061b923.
        return id == 0x9061b923 || id == 0x01ffc9a7;
    }
}

