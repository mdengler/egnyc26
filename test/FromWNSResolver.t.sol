// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console2} from "forge-std/Test.sol";
import {FromWNSResolver} from "../src/FromWNSResolver.sol";

/// @dev Exposes the internal _weiNode so node derivation can be unit-tested.
contract Harness is FromWNSResolver {
    function weiNode(bytes calldata name) external pure returns (bytes32) {
        return _weiNode(name, 0);
    }
}

contract FromWNSResolverTest is Test {
    Harness harness;

    function setUp() public {
        harness = new Harness();
    }

    // --- ERC-165 ---

    function test_supportsInterface() public view {
        assertTrue(harness.supportsInterface(0x9061b923), "IExtendedResolver");
        assertTrue(harness.supportsInterface(0x01ffc9a7), "ERC-165");
        assertFalse(harness.supportsInterface(0xffffffff), "ERC-165 mandates false");
    }

    // --- node derivation (deterministic, no network needed) ---

    function test_weiNode_singleLabel() public view {
        // namehash("eg26nyc.wei") = keccak256(namehash("wei"), keccak256("eg26nyc"))
        bytes32 weiRoot = 0xa82820059d5df798546bcc2985157a77c3eef25eba9ba01899927333efacbd6f;
        bytes32 expected = keccak256(abi.encodePacked(weiRoot, keccak256(bytes("eg26nyc"))));
        assertEq(harness.weiNode(_dns("eg26nyc.fromwei.eth")), expected);
    }

    function test_weiNode_multiLabel() public view {
        // sub.eg26nyc.fromwei.eth -> namehash("sub.eg26nyc.wei")
        bytes32 parent = harness.weiNode(_dns("eg26nyc.fromwei.eth")); // = namehash("eg26nyc.wei")
        bytes32 expected = keccak256(abi.encodePacked(parent, keccak256(bytes("sub"))));
        assertEq(harness.weiNode(_dns("sub.eg26nyc.fromwei.eth")), expected);
    }

    // --- live resolution against mainnet wei-names (needs ETH_RPC_URL) ---

    function test_resolves_eg26nyc_live() public {
        vm.createSelectFork(vm.envString("ETH_RPC_URL"));
        FromWNSResolver resolver = new FromWNSResolver();
        bytes memory data = abi.encodeWithSelector(bytes4(0x3b3b57de), bytes32(0)); // addr(bytes32)
        address a = abi.decode(resolver.resolve(_dns("eg26nyc.fromwei.eth"), data), (address));
        console2.log("eg26nyc.fromwei.eth ->", a);
        assertTrue(a != address(0), "eg26nyc.wei must be active/owned on mainnet");
    }

    // --- helpers ---

    /// @dev DNS-wire-encode a dotted name, e.g. "eg26nyc.fromwei.eth".
    function _dns(string memory name) internal pure returns (bytes memory out) {
        bytes memory s = bytes(name);
        uint256 start = 0;
        for (uint256 i = 0; i <= s.length; i++) {
            if (i == s.length || uint8(s[i]) == 0x2e) {
                // 0x2e == "."
                out = abi.encodePacked(out, bytes1(uint8(i - start)), _slice(s, start, i - start));
                start = i + 1;
            }
        }
        out = abi.encodePacked(out, bytes1(0)); // root terminator
    }

    function _slice(bytes memory s, uint256 start, uint256 len) private pure returns (bytes memory r) {
        r = new bytes(len);
        for (uint256 i = 0; i < len; i++) {
            r[i] = s[start + i];
        }
    }
}
