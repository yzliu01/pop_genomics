## example
#!/bin/bash -l
***************************
https://kbroman.org/github_tutorial/pages/init.html
https://www.gitkraken.com/blog/vs-code-git

1) Can you try closing down vs code and everything else, then (in a new session) going to /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics and committing the things that should be committed. It is important to use a new session because I moved some folders around and vs code might still be looking at a broken folder.

2) Then try pushing that to github. Don't worry about the large files in the .git/

3) In the future, if you have a bad commit what you want is probably `git reset HEAD^` -- this tells git to go back one commit without touching any of the files. That way you could redo the commit without the large files for example.

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