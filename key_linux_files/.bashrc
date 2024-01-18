# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Increase saved history
export HISTSIZE=100000


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yzliu/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yzliu/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/yzliu/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yzliu/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# add the path where starship is to the PATH
export PATH="$PATH:/home/yzliu/miniforge3/bin"
# execute starship to launch color theme
eval "$(starship init bash)"

# execute conda gatk_4.5.0.0
# not working version require java17
export PATH="/home/yzliu/bin/gatk_4.5.0.0/gatk-4.5.0.0/:$PATH"
# working version
export PATH="/home/yzliu/bin/gatk_4.2.6.0/gatk-4.2.6.0/:$PATH"
export PATH="/home/yzliu/bin/gatk_4.2.4.1/gatk-4.2.4.1/:$PATH"
export PATH="/home/yzliu/bin/gatk_4.3.0.0/gatk-4.3.0.0/:$PATH"
