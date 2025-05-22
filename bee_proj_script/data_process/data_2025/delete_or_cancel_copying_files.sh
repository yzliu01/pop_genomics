
ps
#    Stands for Process Status
#    Lists currently running processes

ps aux -h
ps aux

#This is a common BSD-style option combo:
#    a – Show processes for all users
#    u – Display the user/owner of each process
#    x – Include processes not attached to a terminal (e.g., background daemons)

ps ux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
yzliu     907559  0.0  0.0  23312 12288 ?        Ss   May20   1:28 /usr/lib/systemd/systemd --user
yzliu     907564  0.0  0.0 187764 10652 ?        S    May20   0:00 (sd-pam)
yzliu    1460093  0.0  0.0  27164  6668 ?        S    15:51   0:01 sshd: yzliu@notty
yzliu    1460096  0.0  0.0   7388  2560 ?        Ss   15:51   0:00 bash
yzliu    1460301  0.0  0.0   7124  3072 ?        S    15:51   0:00 sh /home/yzliu/.vscode-server/bin/903b1e9d8990623e3d7da1df3d33db3e42d80e
yzliu    1460347  0.2  0.0 984280 118540 ?       Sl   15:51   0:16 /home/yzliu/.vscode-server/bin/903b1e9d8990623e3d7da1df3d33db3e42d80eda/
