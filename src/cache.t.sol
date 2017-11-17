// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.13;


import "ds-test/test.sol";
import "./cache.sol";

contract TestUser {

    function doProd(DSCache cache, bytes32 wut, uint Zzz) {
        cache.prod(wut, Zzz);
    }
}

contract TestableCache is DSCache {

    uint public localTime;

    function TestableCache() public {
        localTime = now;
    }

    function time() internal view returns (uint) {
        return localTime;
    }

    function addTime(uint extra) public {
        localTime += extra;
    }
}

contract DSCacheTest is DSTest {

    TestableCache cache;
    bytes32 data = bytes32("test");
    TestUser user;

    function setUp() public {
        cache = new TestableCache();
        user = new TestUser();
    }

    function testProd() public {
        cache.prod(data, now + 1);
    }

    function testFailProd() public {
        user.doProd(cache, data, now + 1);
    }

    function testHas() public {
        var (wut, has) = cache.peek();
        assertTrue(!has);
        cache.prod(data, now + 1);
        (wut, has) = cache.peek();
        assertTrue(has);
        cache.addTime(1);
        (wut, has) = cache.peek();
        assertTrue(!has);
    }

    function testPeek() public {
        cache.prod(data, now + 1);
        var (wut, has) = cache.peek();
        assertEq(data, wut);
    }

    function testRead() public {
        cache.prod(data, now + 1);
        var wut = cache.read();
        assertEq(data, wut);
    }

    function testFailExpiredRead() public {
        cache.prod(data, now + 1);
        cache.addTime(2);
        cache.read();
    }

    function testFailUninitializedRead() public {
        cache.read();
    }

    function testFailUnsetRead() public {
        cache.prod(data, now + 1);
        cache.void();
        cache.read();
    }

    function testPoke() public {
        cache.prod(data, now + 1);
        cache.addTime(2);
        cache.poke(bytes32("stuff"));
        var (wut, has) = cache.peek();
        assertEq(wut, bytes32("stuff"));
        assertTrue(!has);
    }

    function testVoid() public {
        cache.prod(data, now + 1);
        cache.void();
        var (wut, has) = cache.peek();
        assertEq(wut, data);
        assertTrue(!has);
    }

}