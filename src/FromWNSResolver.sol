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

contract FromWNSResolver {

    /*
      ENSIP-10-compliant ENS resolvers MAY implement the following function interface:

interface ExtendedResolver {
    function resolve(bytes calldata name, bytes calldata data) external view returns(bytes);
}
    */

    function resolve(bytes calldata name, bytes calldata data) {
        bytes record = "";
        // stub
        return record;
    }

    /*
      /*
  If a resolver implements [resolve(..)], it MUST return true when supportsInterface() is called on it with the interface's ID, 0x9061b923.
     */
    function supportsInterface(int calldata id) {
        return id == 0x9061b923;
    }
}


/*
ENS clients will call resolve with the DNS-encoded name to resolve and the encoded calldata for a resolver function (as specified in ENSIP-1 and elsewhere); the function MUST either return valid return data for that function, or revert if it is not supported.

ENSIP-10-compliant ENS clients MUST perform the following procedure when determining the resolver for a given name:

Set currentname = name
Set resolver = ens.resolver(namehash(currentname))
If resolver is not the zero address, halt and return resolver.
If currentname is the empty name ('' or '.'), halt and return null.
Otherwise, set currentname = parent(currentname) and go to 2.
If the procedure above returns null, name resolution MUST terminate unsuccessfully. Otherwise, ENSIP-10-compliant ENS clients MUST perform the following procedure when resolving a record:

Set calldata to the ABI-encoded call data for the resolution function required - for example, the ABI encoding of addr(namehash(name)) when resolving the addr record.
Set supportsENSIP10 = resolver.supportsInterface('0x9061b923').
If supportsENSIP10 is true, set result = resolver.resolve(dnsencode(name), calldata)
If supportsENSIP10 is false and name == currentname, set result to the result of calling resolver with calldata.
If neither 3 nor 4 are true, terminate unsuccessfully.
Return result after decoding it using the return data ABI of the corresponding resolution function (eg, for addr(), ABI-decode the result of resolver.resolve() as an address).
Note that in all cases the resolution function (addr() etc) and the resolve function are supplied the original name, not the currentname found in the first stage of resolution.

Also note that when wildcard resolution is in use (eg, name != currentname), clients MUST NOT call legacy methods such as addr to resolve the name. These methods may only be called on resolvers set on an exact match for name.

Pseudocode
￼
function getResolver(name) {
    for(let currentname = name; currentname !== ''; currentname = parent(currentname)) {
        const node = namehash(currentname);
        const resolver = ens.resolver(node);
        if(resolver != '0x0000000000000000000000000000000000000000') {
            return [resolver, currentname];
        }
    }
    return [null, ''];
}
 
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
Specification
The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in RFC 2119.

Let:

namehash be the algorithm defined in ENSIP-1.
dnsencode be the process for encoding DNS names specified in section 3.1 of RFC1035, with the exception that there is no limit on the total length of the encoded name. The empty string is encoded identically to the name '.', as a single 0-octet.
parent be a function that removes the first label from a name (eg, parent('foo.eth') = 'eth'). parent('tld') is defined as the empty string ''.
ens is the ENS registry contract for the current network.
ENSIP-10-compliant ENS resolvers MAY implement the following function interface:

￼
interface ExtendedResolver {
    function resolve(bytes calldata name, bytes calldata data) external view returns(bytes);
}
If a resolver implements this function, it MUST return true when supportsInterface() is called on it with the interface's ID, 0x9061b923.

ENS clients will call resolve with the DNS-encoded name to resolve and the encoded calldata for a resolver function (as specified in ENSIP-1 and elsewhere); the function MUST either return valid return data for that function, or revert if it is not supported.

ENSIP-10-compliant ENS clients MUST perform the following procedure when determining the resolver for a given name:

Set currentname = name
Set resolver = ens.resolver(namehash(currentname))
If resolver is not the zero address, halt and return resolver.
If currentname is the empty name ('' or '.'), halt and return null.
Otherwise, set currentname = parent(currentname) and go to 2.
If the procedure above returns null, name resolution MUST terminate unsuccessfully. Otherwise, ENSIP-10-compliant ENS clients MUST perform the following procedure when resolving a record:

Set calldata to the ABI-encoded call data for the resolution function required - for example, the ABI encoding of addr(namehash(name)) when resolving the addr record.
Set supportsENSIP10 = resolver.supportsInterface('0x9061b923').
If supportsENSIP10 is true, set result = resolver.resolve(dnsencode(name), calldata)
If supportsENSIP10 is false and name == currentname, set result to the result of calling resolver with calldata.
If neither 3 nor 4 are true, terminate unsuccessfully.
Return result after decoding it using the return data ABI of the corresponding resolution function (eg, for addr(), ABI-decode the result of resolver.resolve() as an address).
Note that in all cases the resolution function (addr() etc) and the resolve function are supplied the original name, not the currentname found in the first stage of resolution.

Also note that when wildcard resolution is in use (eg, name != currentname), clients MUST NOT call legacy methods such as addr to resolve the name. These methods may only be called on resolvers set on an exact match for name.

Pseudocode
￼
function getResolver(name) {
    for(let currentname = name; currentname !== ''; currentname = parent(currentname)) {
        const node = namehash(currentname);
        const resolver = ens.resolver(node);
        if(resolver != '0x0000000000000000000000000000000000000000') {
            return [resolver, currentname];
        }
    }
    return [null, ''];
}
 
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
