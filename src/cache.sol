// store.sol -- authed nullable key-value store with expirations

// Copyright 2016-2017  DappHub, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// A copy of the License may be obtained at the following URL:
//
//    https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

pragma solidity ^0.4.8;

import 'ds-value/value.sol';

contract DSCache is DSValue
{
    uint128 public zzz;
//  from DSValue:
//  bool    has;
//  bytes32 val;
    function peek() constant returns (bytes32, bool) {
        return (val, has && now < zzz);
    }
    function read() constant returns (bytes32) {
        var (wut, has) = peek();
        assert(now < zzz);
        assert(has);
        return wut;
    }
    function prod(bytes32 wut, uint128 Zzz) note auth {
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
