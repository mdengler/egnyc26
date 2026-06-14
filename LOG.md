## ETHGlobal 2026 NYC submission  TeamA (working name)

### high-level TODOs

- [x] learn options
- [x] brainstorm ideas
- [x] select idea
- [x] make connections throughout
- [x] create stubs
- [x] one 'implement - test - deploy' loop
- [ ] create demo
- [ ] create logos
- [ ] record video
- [ ] put in project submission
- [ ] refine as time allows
- [ ] document
- [ ] say thanks and goodbyes


### implementation scratchpad

test/FromWNSResolver.t.sol
check test wei name - use martindengler.wei
interate on "subway runbook" steps
check time constraints and fill in project submission web page


### Next study steps

- solidity interface vs contract declaration nuances (e.g., why `returns` goes in `interface` and not `contract`)


### Journal


#### 2026-06-14 08:47

Deployed!

```
20260614-08:44.50 martin@cdcx4 eg ▶ $ forge create src/FromWNSResolver.sol:FromWNSResolver --rpc-url "$ETH_RPC_URL" --account deployer --broadcast
Enter keystore password:
[⠊] Compiling...
No files changed, compilation skipped
Deployer: 0xf4F7F1BD0905EFe61382dE895eC3C1eD321B995b
Deployed to: 0x8403F2BEE92296a1858fb83A019899D01a502abe
Transaction hash: 0x1d33b17d55f9d7e367300e0d1f6cb576f283b5d73d915bf6ec28182a74ba4795

```


#### 2026-06-14 07:57

Going to checkpoint, then lean on Claude for implementation but really interested to put this all together afterwards into one of the bigger project ideas I had: 1inch SwapVM extruction to resolve WNS names as a small part of a larger "manufacturer-rebate servicing app" Aqua app to leverage the subscription idea and earn yield on the "accounts-payable"-like rebate cash.


#### 2026-06-14 07:45

Checkpoint.  Time to accellerate to make the submission deadline; learned a lot already.


#### 2026-06-14 06:45

Correct contract code location.  Time to do some solidity hacking.


#### 2026-06-14 06:33

Created `fromwei-resolver` and moved my stub solidity contract there:

```
forge init --no-git --offline fromwns-resolver && cd fromwns-resolver
mv ../src/FromWNSResolver.sol .
```


#### 2026-06-14 06:15

On subway now, so no internet :).  Got emacs-solidity installed for M-x solidity-mode and started `FromWNSResolver.sol`.  Got https://github.com/z0r0z/zolidity prerequisites updated while stopped at a station.


#### 2026-06-14 06:00

Heading back to the hackathon; feeling better.  Need to get a contract written and tested in foundry.  Claude pointed out that I wasn't articulating that "'Solidity runs on-chain in the EVM as a result of transactions' is correct for writes. But reads don't use transactions [so those are simply run via a local EVM]" had not made it into my mental model explicitly.  That is a key realisation.  TIme to get back to contract writing, though.


#### 2026-06-13 18:00

Progress, but feeling ill.  Heading out to sleep.


#### 2026-06-13 17:20

Discussing tooling and best practices with claude.  I will include the transcript in my repo.  I would also love to have this type of conversation with an experienced ethereum developer in-person, but I'm hacking solo and it's only 12 hours to submission deadline, so I don't think anyone's going to enjoy random conversations like this right now!.



#### 2026-06-13 17:15

  - [x] register fromwei.eth on ENS: https://app.ens.domains/fromwei.eth/register second transaction failed on chrome and metamask on desktop, but did it from iOS and it was fine; weird and ate 30 mins for no reason :/


#### 2026-06-13 16:28

wei-names uses foundry, and I'm on Fedora, so I'll go with the tools used in the wei-names repo:

- goal: eg26nyc.fromwei.eth should resolve via ENS to something cool
  - [x] register eg26nyc.wei at https://zfi.wei.is/domains/#eg26nyc via  https://etherscan.io/tx/0x3f54eee7af8d052f101c761e1cba33cacb19922e609f5360001b32682b4c8789
  - [ ] register fromwei.eth on ENS: https://app.ens.domains/fromwei.eth/register 

I consulted Claude Opus[^1] on the plan, and it recommended reading z0r0z/zolidity too, so I'm going to read that...looks like I had that idea a long time ago:

```
20260613-16:42.41 martin@cdcx4 eg ▶ $ ls -lad ~/src/zolidity/.git
drwxr-xr-x. 6 martin martin 4096 May 28  2024 /home/martin/src/zolidity/.git/
```

...but I imagine things have changed since then, so lots of reading to do.



#### 2026-06-13 14:56

read source code of experts: https://github.com/z0r0z/wei-names

Need to normalize labels:

```
import { ens_normalize } from '@adraffy/ens-normalize';

function normalizeLabel(label) {
  try {
    const normalized = ens_normalize(label);
    if (normalized.includes('.')) return null; // No dots in labels
    return normalized;
  } catch (e) {
    return null; // Invalid (confusables, invisible chars, etc.)
  }
}
```


Note:

Best Practices for Integrators
- Normalize input with ENSIP-15 before registration (same as ENS)
- Use the verification tool or compute expected token IDs when buying on secondary markets
- Display normalization warnings for names that don't pass ENSIP-15
- Link to the official dapp (wei.domains/#name) for name lookups
- Check isActive state before displaying resolver data — expired names return empty from all resolver reads
- Handle refund failures — if your contract calls reveal or renew, ensure it can receive ETH refunds


Wei names subdomain contract: https://etherscan.io/address/0x53745292f0d30d68204a63002C17bDa16C772bf7#code


So much to read and figure out what's relevant :).  Need a break from reading; back soon (for real this time).



#### 2026-06-13 13:00

Back at site. No response on my Discord message about AppClip or paymaster ERC-4337 support, so I'll just do it myself.



#### 2026-06-13 10:30

I need to read about ERC wei-names resolution and how I can deploy a contract that adheres to ENSIP-10 (wildcard resolution) and calls the wei-names contract.

- ENSIP-10: https://docs.ens.domains/ensip/10/
- Deploying your first smart contract: https://ethereum.org/developers/tutorials/deploying-your-first-smart-contract/
- tenderly: for testing
  - 
  - e.g.:
    - https://dashboard.tenderly.co/tx/arbitrum/0x1fa461cfc27f25a87d9ed6f43de7c150abb456b0bb483ac19b8af5020e27594a/debugger?trace=0.5.0.0.1.2 related to https://arbiscan.io/tx/0x1fa461cfc27f25a87d9ed6f43de7c150abb456b0bb483ac19b8af5020e27594a
    - https://dashboard.tenderly.co/tx/sepolia/0x56d35cb856bbb7216afe930ee25514d080ce97bc68da8d9cf2d8fb6d44285099/debugger?trace=0.4.1
    - https://dashboard.tenderly.co/drnick/project/simulator/bb90c1ea-2b41-47c5-80e6-be18e5ba0123


##### stub contract:

```
interface ExtendedResolver {
    function resolve(bytes calldata name, bytes calldata data) external view returns(bytes);
}
```



#### 2026-06-13 01:00

USA won; getting some sleep.



#### 2026-06-12 21:20-21:55

Spoke at some length with Tammer from 1-inch about their offerings and got some feedback about about maybe adding an new custom opcode to their SwapVM product or using a "extruction" (sp?) to create a Aqua 0 ENS- and wei-names resolving Aqua App example/prototype...but forgot (in the moment) the details of the gift-card / rebate idea!  Dumbass.  Now that I've gotten back to the written notes with that idea, I can see a) it's pretty decent!; and b) could be more work than I can manage, but perhaps if I get some help tomorrow, can be done.

Then went to floor 3 for a workshop on team formation, but it was mostly over because I had talked so long with Tammer.  All good, because I suppose that was the point of the hackathon and he was very helpful & supportive.  Excited to think about this a bit more.  No response from anyone in discord about teaming up yet.



#### 2026-06-12 21:15

Added template headings to README.md.  Started to fill in this LOG.md.

Current ideas set:

##### circle/aqua

- gift cards or rebates as aqua apps
- new swapvm opcode to resolve wei names

##### ens
- straightforward wei name resolution
- appclip to prove you went someplace
- bootstrapping a wei name (weiwei.eth?) via paymaster or world.id human-only credit


Sent a message to the hackathon's discord about AppClips and paymasters after this.



#### 2026-06-12 21:03.44

Initial empty repo.  Got to pick an idea and get to the USA-Paraguay game watch party ... erm, "ideate".

```
20260612-21:03.41 martin@cdcx4 ~ ▶ $ cd ~/src/eg
bash: cd: /home/martin/src/eg: No such file or directory
20260612-21:03.44 martin@cdcx4 ~ ▶ $ mkdir ~/src/eg
20260612-21:03.48 martin@cdcx4 ~ ▶ $ cd ~/src/eg
20260612-21:03.54 martin@cdcx4 eg ▶ $ git init
Initialized empty Git repository in /home/martin/src/eg/.git/
20260612-21:03.55 martin@cdcx4 eg ▶ $ touch README.md
20260612-21:04.01 martin@cdcx4 eg ▶ $ touh LOG.md
bash: touh: command not found
20260612-21:04.03 martin@cdcx4 eg ▶ $ touch  LOG.md
20260612-21:04.07 martin@cdcx4 eg ▶ $ ls -la
total 20
drwxr-xr-x.   3 martin martin  4096 Jun 12 21:04 ./
drwxrwxr-x. 275 martin martin 12288 Jun 12 21:03 ../
drwxr-xr-x.   5 martin martin  4096 Jun 12 21:03 .git/
-rw-r--r--.   1 martin martin     0 Jun 12 21:04 LOG.md
-rw-r--r--.   1 martin martin     0 Jun 12 21:04 README.md
20260612-21:04.35 martin@cdcx4 eg ▶ $ git add .gitignore
20260612-21:04.47 martin@cdcx4 eg ▶ $ git commit -m "inital empty commit" -a
[main (root-commit) abd8130] inital empty commit
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore
20260612-21:04.59 martin@cdcx4 eg ▶ $ git commit -m "inital empty commit" ^C
20260612-21:05.05 martin@cdcx4 eg ▶ $ git add LOG.md README.md 
20260612-21:05.10 martin@cdcx4 eg ▶ $ git commit -m "inital empty commit" --amend
[main 175c2e7] inital empty commit
 Date: Fri Jun 12 21:04:59 2026 -0400
 3 files changed, 1 insertion(+)
 create mode 100644 .gitignore
 create mode 100644 LOG.md
 create mode 100644 README.md
```



#### 2026-06-12 21:00

Idea & team gestation time.  I came here with one idea, maybe two:

1. integrate .wei into ENS
2. do some cool ethereum thing involving people showing they had been fans before person/thing was cool.

#1 might be too small, #2 is a UX problem atop a technical cambrian mess.

Thought for a while before I came up with the below (and then wrote this entry):

I think I'll use appclips to make the UX really cool, and perhaps I can either combine the two ideas I had or adapt somehow.  One issue with .wei names -- specifically, *onboarding* people into .wei names -- might be bootstrapping money to pay for the .wei names (though there are free ones, I don't think it's going to integrate well enough).  Having read about implementation of idea #1 last night, I DM'ed the wei-names developer last night about it in case he has ideas/objections/prior-art, but haven't heard from him yet.   Maybe I can use ENS registrar delegation with a auto-generated wei name to create subnames that are funded by ETH paymaster or by a "my friend can onboard me with a tiny bit of ETH for gas within an appclip" (this workflow seems very workable based on the AppClip example I keep thinking of, which is ToastTab that shows just-in-time data (receipt) and pre-compiled data (the AppClip itself)).





#### 2026-06-12 15:45

arrived, signed in, and walked the floor then went to a few workshops.  Threw around a few ideas as incoherently as normal: forget about product-market fit, there is a ton of impedance mismatch between the retail/spouse-experience of crpyto and the laser-focused APIs and spaces people are talking about us building on.

