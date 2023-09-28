// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {console2 as console} from "forge-std/Test.sol";

interface IChallenge {
    function memIt() external view returns (bytes32, bytes32);
}

// ******* This is for use by the challenge creator only!     *******
// ******* Players do not need to change anything here. *******
library CREATOR {
    uint8 internal constant _challengeId = 0x99; // IMPORTANT: CREATOR TO UPDATE THIS!

    // IMPORTANT: CREATOR TO UPDATE THIS!
    // This function returns true or false if the solution is correct.
    // Write logic that will check if the provided solution is correct
    function verify(address solution) internal returns (bool) {
        (bytes32 d1_, bytes32 d2_) = IChallenge(solution).memIt();
        uint d1 = uint(d1_);
        uint d2 = uint(d2_);
        uint caller = uint256(uint160(address(this)));
        uint callerHash = uint(keccak256(abi.encode(caller)));
        uint number = uint(uint(block.number));
        uint timestamp = uint(block.timestamp);

        require(compareQuarterWords(d1, 0, callerHash, 0));
        require(compareQuarterWords(d1, 1, callerHash, 1));
        require(compareQuarterWords(d1, 2, caller, 1));
        require(compareQuarterWords(d1, 3, callerHash, 0));
        require(compareQuarterWords(d2, 0, caller, 3));
        require(compareQuarterWords(d2, 1, timestamp, 3));
        require(compareQuarterWords(d2, 2, number, 3));
        require(compareQuarterWords(d2, 3, caller, 2));

        return true;
    }

    function compareQuarterWords(uint x, uint nX, uint y, uint nY) internal pure returns (bool) {
        uint mask =  0xffffffffffffffff;
        uint x1 = (x >> ((3 - nX) * 64)) & mask;
        uint y1 = (y >> ((3 - nY )* 64)) & mask;
        return x1 == y1;
    }

    // IMPORTANT: CREATOR TO UPDATE THIS!
    // his function should return the number that should reported for gas for the solution.
    // It could be the measurement of a single function call or multiple.
    function gasReport(address solution) internal returns (uint256 gasUsed) {
        // add logic to report gas cost of the relevant call or calls to the solution
        uint256 start = gasleft();
        IChallenge(solution).memIt();
        gasUsed = start - gasleft();
    }

    function challengeId() internal pure returns (uint8) {
        require(_challengeId != 0xff, "IMPORTANT: CREATOR to update challengeId!");
        return _challengeId;
    }
}
