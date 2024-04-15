

Remember to read the "Getting started" documentation for GenomeDK users at www.genome.au.dk - it will save you a lot of time :-)

To protect your files from accidental deletion, add "alias rm='rm -i'" (remove double quotes) to the end of the .bashrc file in your home folder. When you now use the rm (remove) command, you will be prompted if you are sure, before the file or folder is deleted. Do the same for the mv and cp commands to avoid accidentally overwriting files. You can add a second alias for removal without prompt (force), for when you need to remove a directory and do not want to be prompted about every file: "alias rm_force='rm -f'". Similarly, for the mv and cp commands, add for instance "alias mv_overwrite='mv'". However, you should still be careful not to accidentally delete files when using terminal software like MobaXTerm - if you start renaming a file in the graphical interface, but then press enter when the file has no name, i.e. is called ".", then all files in the folder will be deleted! This is one of many reasons to use the command line interface as much as possible :-)

Also, never use spaces or special characters (such as "�", "�", "�") in directory names, as many programs can't deal with this!


Some useful basic bash commands are given here. For more bash guidance, see e.g. https://mywiki.wooledge.org/EnglishFrontPage.

man COMMAND: See the manual for a command

cd: Change directory. Change to certain directory name if provided.

    cd foo takes you to the directory foo.
    Changes to home directory if no directory specified.
    
pwd: Show the path of your current/working directory    

ls: Show directory contents, lists names of files.

less: View contents of specified file, page by page.

head/tail: Display the first/last 10 lines of a file.

mkdir: Creates a directory of the specified name.

    mkdir foo creates a directory called "foo".

rm: Remove a specified file. This action is permanent. There is no recycle bin.

rmdir: Remove a directory. This action is permanent. There is no recycle bin.

cp: Copy specified file to a new location. Use -r flag to copy a directory. 

mv: Move or rename a specified file or directory.

gunzip: Unzip a .gz file

tar -xzf: Untar a tar.gz file

wc: Count number of lines (-l), words (-w), or bytes (-c) in a file

history: Display a listing of the last commands you've run.

CTRL+R: Search through previous commands. Use CTRL+R again to scroll through search results

CTRL+A: Move to start of line/command

CTRL+E: Move to end of line/command

ALT+F: Move forward one word

ALT+B: Move	back one word

diff file1 file2: Compare two files line by line

tree . : Overview of files and folders



Some useful commands for running jobs/processes

srun --pty /bin/bash: Run an interactive job. The queueing system allows us to either submit an interactive or batch job. An interactive job effectively gives you a shell on a compute node so that you can type commands and run programs that will run on that node. This is great for experimenting and debugging problems. While interactive jobs are useful, they require you to be logged in to the node while your computations one the node are running.

squeue -u USERNAME: See your current jobs and their status

watch NAME_OR_COMMAND: See a continuous update of e.g. squeue or a log file

kill PID: Cancel a running process with id "PID"

top: Show all ongoing processes

top -cu YOUR_USERNAME: Check your running processes

nohup COMMAND &: Run a command directly from the terminal, but allows you to continue working


Working with screens:

screen -S NAME: Make new screen

CTRL+A+D: go out of screen

screen -r NAME: go into the screen

screen -ls: see all screens

screen -X -S NAME kill: stop process

screen -x NAME: reattach attached screen


