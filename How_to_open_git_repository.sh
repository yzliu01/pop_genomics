## example
#!/bin/bash -l
***************************
https://kbroman.org/github_tutorial/pages/init.html
https://www.gitkraken.com/blog/vs-code-git

#1) Can you try closing down vs code and everything else, then (in a new session) going to /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics and committing the things that should be committed. It is important to use a new session because I moved some folders around and vs code might still be looking at a broken folder.

#2) Then try pushing that to github. Don't worry about the large files in the .git/

#3) In the future, if you have a bad commit what you want is probably `git reset HEAD^` -- this tells git to go back one commit without touching any of the files. That way you could redo the commit without the large files for example.

Best,
Anders


ssh -T git@github.com

## 1st open command pallete
ctrl + shift + P
## 2nd choose below command
Git: Open Repository
## 3rd enter below the cloned/linked directory
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/

find . -size +100M | cat >> .gitignore


********* connect a VScode folder to git repo *********

## https://kbroman.org/github_tutorial/pages/init.html

git push -u origin master
git init
git add
git add .gitignore
git remote add origin https://github.com/yzliu01/pollinator_decline_demography
#error: remote origin already exists
git commit -m "initial commit"

git remote show origin
git remote add origin https://github.com/yzliu01/pollinator_decline_demography

git remote -v
#origin  git@github.com:yzliu01/demographic_modelling_of_pollinator_declining (fetch)
#origin  git@github.com:yzliu01/demographic_modelling_of_pollinator_declining (push)

git push -u origin main

git remote remove origin

git remote add origin https://github.com/yzliu01/pollinator_decline_demography
## https://stackoverflow.com/questions/75273156/gitolite-error-src-refspec-master-does-not-match-any
## https://stackoverflow.com/questions/54837083/git-problem-error-src-refspec-origin-does-not-match-any
git show-ref
git status
git branch -avv

git pull https://github.com/yzliu01/pollinator_decline_demography main --allow-unrelated-histories
## https://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories-on-rebase

#error: Pulling is not possible because you have unmerged files.
#hint: Fix them up in the work tree, and then use 'git add/rm <file>'
#hint: as appropriate to mark resolution and make a commit.

## https://stackoverflow.com/questions/26376832/why-does-git-say-pull-is-not-possible-because-you-have-unmerged-files
git add .
git commit -m "test"

git push --set-upstream origin main