# git-bisect-playground

Test out [git bisect](https://git-scm.com/docs/git-bisect) functionality

## Ideal scenario with tests

1. You have to start by `git bisect start`.
1. Mark at least one good (`git bisect good {{commit}}`) and one bad (`git bisect bad {{commit}}`) commit.
1. Bisect will try to find the errorous commit with a binary search.

```bash
git bisect start
git bisect good 5e466f7
git bisect bad e5b8999
git bisect run ./test.sh
git bisect reset
```


If you have a script that can tell if the current source code is good or bad, you can bisect by issuing the command:

    git bisect run my_script arguments

Note that the script (my_script in the above example) should exit with code 0 if the current source code is good/old, and exit with a code between 1 and 127 (inclusive), except 125, if the current source code is bad/new.


```text
running ./test.sh
Bisecting: 2 revisions left to test after this (roughly 1 step)
[2ea6fb3d6b2fbc77560eaa070c45f82a935b0c7a] 7
running ./test.sh
Bisecting: 0 revisions left to test after this (roughly 1 step)
[d0e396501e12b27796da22e8c7fa38c3954e6351] 9
running ./test.sh
fail
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[6320544bf389916f91a533e4d45f5a5541303e07] 8
running ./test.sh
fail
6320544bf389916f91a533e4d45f5a5541303e07 is the first bad commit
commit 6320544bf389916f91a533e4d45f5a5541303e07
Author: Mátyás Budavári <budavariam@gmail.com>
Date:   Tue Mar 27 17:24:30 2018 +0200

    8

:100644 100644 7f8f011eb73d6043d2e6db9d2c101195ae2801f2 45a4fb75db864000d01701c0f7a51864bd4daabf M      data.txt
bisect run success
```

## If you do the steps manually make a mistake and do not want to start again

You can save the current bisect log into a file, modify some entries, and make bisect replay your changes.

```bash
git bisect start
git bisect good 5e466f7
git bisect bad e5b8999
#Bisecting: 4 revisions left to test after this (roughly 2 steps)
#[7d43b4e7a5124f46f51c15c6c43243c3171fefdd] 5
git bisect bad
# oooooooooops, it should be good
git bisect log > bisect.log
#remove last 2 lines:
# # bad: [7d43b4e7a5124f46f51c15c6c43243c3171fefdd] 5
# git bisect bad 7d43b4e7a5124f46f51c15c6c43243c3171fefdd
git bisect reset
git bisect replay bisect.log
```