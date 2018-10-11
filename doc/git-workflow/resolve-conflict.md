# How to resolve a conflict

If a branch cannot be merged due to a conflict, use the folling steps (the
steps on github do not work because they merge manually into master and
push master - you cannot push master)

Merge conflict in branch feature_1

## Have current version of the branch on local machine

If you hadn't had the branch locally before

    git fetch origin feature_1
    git checkout feature_1

otherwise just update it

    git checkout feature_1
    git pull origin feature_1

## Make sure you have the newest version of master

    git checkout master
    git pull origin master

## Checkout branch and merge

    git checkout feature_1
    git merge master

NO REBASE! otherwise the history of feature_1 will be rewritten. As it has
already published to github, this isn't a great idea.

rebase conflicts locally if necessary, commit.

    git push origin feature_1
