# Welcome to Huff Challenge 0.2: Memory Enjoyoor

Greetings, Huffoor! This document will guide you through the steps to solve this challenge and register your solution.

**NOTE** -- after you submit, if you want to change your Huff code (for example to try and optimize even more) Please remember to retain your original code that matches the hash! The winner's Huff code will be human reviewed and if it doesn't match the Hash you submitted then it will not count.

## Overview

In this challenge you must complete a function with the goal of correctly setting up the memory in the most gas efficient way. You do not need to write `MAIN()` or any other functions, this is strictly an exercise in memory building.

The memory that you need to setup is two words between 0x00 and 0x40. It involves 4 values:

```
A) uint256(msg.sender (caller))
B) uint256(keccak hash of msg.sender)
C) uint256(block.number)
D) uint256(block.timestamp)
```

So each is a 32byte word.  Each value can be divided into four 8-byte pieces ("quarters").  So the final memory setup involves stacking different "quarters". Each value is annotated by their letter and the corresponding "quarter" (1-4) starting from left to right.  For example:

```
A) 0x0000000000000000 0000000034a1d3ff f3958843c43ad80f 30b94c510645c316 // msg.sender
B) 0xfe2afc3f161bf87c 530b1b36a14b99f2 2e6eb09c76ab0f05 72d39ad6f7b8f784 // hash of msg.sender
C) 0x0000000000000000 0000000000000000 0000000000000000 000000000093f028 // block number
D) 0x0000000000000000 0000000000000000 0000000000000000 000000006511c5a6 // block timestamp
```

The "quarters" are annotated as follows:

```
A-1 the highest 8 bytes of the msg.sender: 0x0000000000000000
A-2 the next 8 bytes                     : 0x0000000034a1d3ff
A-3                                      : 0xf3958843c43ad80f
A-4                                      : 0x30b94c510645c316

B-1                                      : 0xfe2afc3f161bf87c
...
C-4                                      : 0x000000000093f028
...
D-4                                      : 0x000000006511c5a6
```

So with that in mind, the goal of this challenge is to arrange the memory from 0x00 - 0x40 as follows:

```
0x00: B-1
0x08: B-2
0x10: A-2
0x18: B-1
0x20: A-4
0x28: D-4
0x30: C-4
0x38: A-3
 ```
Yes you can change the `Solution.t.sol` test file as much as you want, it is there to help you and for you to use as you see fit.  It will not affect the outcome or the registration process.

During the human review, the winner's `PLAYERS_SOLUTION.huff` will be fully tested.


## Getting Started

1. **Clone the Repo**: Start by cloning this repository to your local machine.

```bash
git clone <REPO_URL>
```

If you're considering sharing your solution later or want to track your progress with commits, you may want to create a fork of this repository. However, remember to keep your fork private initially to prevent others from seeing your solution.

2. **Solve the Puzzle**: Dive into the [PLAYER_SOLUTION.huff](src/PLAYER_SOLUTION.huff) file and work your magic to solve the challenge.

3. **Testing**: While solving, you can utilize the test suite [Solution.t.sol](test/Solution.t.sol) to validate your solution. Feel free to make changes to this file; it won't affect the main challenge or your submission. It's just there to assist you.

## Registering Your Solution

Once you're confident in your solution, register it with the HuffCTFRegistry on Optimism mainnet:

1. **Set Up Your Discord Handle**: Before running the registration script, set up an environment variable with your Discord handle (without the '@' symbol):

```bash
export PLAYER_HANDLE=devtooligan
```

2. **Run the Registration Script**: Use the following command to run the registration script:

```bash
forge script script/Solution.s.sol:Register --rpc-url <OPTIMISM RPC URL> --broadcast -vvvv
```

Note:
- This command sends a live transaction on Optimism. Replace `<OPTIMISM RPC URL>` with a valid URL.
- You'll need to use an actual wallet for the transaction. You can specify your wallet using the `--wallet` flag. Alternatively, you can input your private key in other ways, such as by using the `--interactive` flag. See [Foundry documentation](https://book.getfoundry.sh/) for more information.


Also note:
- You can also interact directly with the Optimism [block explorer](https://optimistic.etherscan.io/address/0xf6aE79c0674df852104D214E16AC9c065DAE5896#writeContract). This is not the recommended way due to the danger of human error. If you want to see the exact input parameters you can run the Register script above and DO NOT use a private key.  The arguments will be console.logged for you.

## Wrapping Up


**!!!Very important** -- after you submit, if you want to change your Huff code (for example to try and optimize even more) Please remember to retain your original code that matches the hash!    The winner's Huff code will be human reviewed and if it doesn't match the Hash you submitted then it will not count.

That's all there is to it! Once the challenge concludes, feel free to make your repository public. If your solution ranks among the top contenders, it will undergo a human review. Stay updated by keeping an eye on our Discord channel and Twitter feed.

Best of luck, and may the best coder win!
