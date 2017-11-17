// cache.sol -- authed nullable key-value store with expirations

// Copyright 2016-2017  DappHub, LLC

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

import 'ds-value/value.sol';

contract DSCache is DSValue
{
    uint public zzz;

    function time() internal view returns (uint) {
        return block.timestamp;
    }

    function peek() public view returns (bytes32, bool) {
        return (val, has && time() < zzz);
    }

    function read() public view returns (bytes32) {
        var (wut, has) = peek();
        assert(time() < zzz);
        assert(has);
        return wut;
    }

    function prod(bytes32 wut, uint Zzz) public note auth {
        zzz = Zzz;
        poke(wut);
    }

}
