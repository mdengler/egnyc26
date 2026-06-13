### ETHGlobal 2026 NYC submission  TeamA (working name)



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

