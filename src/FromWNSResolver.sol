// From https://github.com/z0r0z/zolidity and https://github.com/z0r0z/wei-names


/*
- supportsInterface → true for 0x9061b923 (ENSIP-10 IExtendedResolver) and 0x01ffc9a7 (ERC-165).
- resolve(bytes name, bytes data): parse the DNS-encoded name, take the label under fromwei.eth, compute weiNode = keccak256(namehash("wei"), keccak256(label)). Because wei-names sets tokenId = uint256(namehash) (EIP-137), that node is the lookup key — no registry hop needed.
- Switch on data's selector → call wei-names → abi.encode the result: addr(bytes32)=0x3b3b57de, addr(bytes32,uint256)=0xf1cb7e06, text(bytes32,string)=0x59d1d43c, contenthash(bytes32)=0xbc1c58d1.
*/



/*
Specification
The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in RFC 2119.

Let:

namehash be the algorithm defined in ENSIP-1.
dnsencode be the process for encoding DNS names specified in section 3.1 of RFC1035, with the exception that there is no limit on the total length of the encoded name. The empty string is encoded identically to the name '.', as a single 0-octet.
parent be a function that removes the first label from a name (eg, parent('foo.eth') = 'eth'). parent('tld') is defined as the empty string ''.
ens is the ENS registry contract for the current network.
*/


    /*
      ENSIP-10-compliant ENS resolvers MAY implement the following function interface:

interface ExtendedResolver {
    function resolve(bytes calldata name, bytes calldata data) external view returns(bytes);
}
    */

interface IWNS {
    function resolve(uint256 tokenId) external view returns (address);
}


contract FromWNSResolver {

    function resolve(bytes calldata name, bytes calldata data) {
        bytes record = "";
        // stub
        return record;
    }

    /*
      /*
  If a resolver implements [resolve(..)], it MUST return true when supportsInterface() is called on it with the interface's ID, 0x9061b923.
     */
    function supportsInterface(bytes4 id) external pure returns (bool) {
        return id == 0x9061b923 ;
    }

    /*
      Questions from supportsInterface (basic solidity):
        - why bytes4 and not int?
        - why not `calldata`
        - what's up with `external pure returns (bool)` -- where is `returns` in the `resolve` function?  I can guess what "pure" means, but how about "external"?  Whence the magical claude-suggested 0x01ffc9a7 for ERC-165, and why?
     */
}


/*
function resolve(name, func, ...args) {
    const [resolver, resolverName] = getResolver(name);
    if(resolver === null) {
        return null;
    }
    const supportsENSIP10 = resolver.supportsInterface('0x9061b923');
    if(supportsENSIP10) {
        const calldata = resolver[func].encodeFunctionCall(namehash(name), ...args);
        const result = resolver.resolve(dnsencode(name), calldata);
        return resolver[func].decodeReturnData(result);
    } else if(name == resolverName) {
        return resolver[func](...args);
    } else {
        return null;
    }
}
*/
