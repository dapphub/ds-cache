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
    uint128 public zzz;
//  from DSValue:
//  bool    has;
//  bytes32 val;
    function peek() public view returns (bytes32, bool) {
        return (val, has && now < zzz);
    }
    function read() public view returns (bytes32) {
        var (wut, has) = peek();
        assert(now < zzz);
        assert(has);
        return wut;
    }
    function prod(bytes32 wut, uint128 Zzz) public note auth {
        zzz = Zzz;
        poke(wut);
    }
    // from DSValue:
    // function poke(bytes32 wut) note auth {
    //     val = wut;
    //     has = true;
    // }
    // function void() note auth { // unset the value
    //     has = false;
    // }

}
