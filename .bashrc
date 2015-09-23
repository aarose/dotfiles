export WORKON_HOME=$HOME/Development/virtualenvs
export PROJECT_HOME=$HOME/Development
export TERM=xterm-256color
source /usr/local/bin/virtualenvwrapper.sh


# Aliases
alias python=python3
alias ls="ls -F --color"  # turn on ls colours 


# Start SSH agent and add key
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi



# -------------- GIT COLOURED OUTPUT MODIFIED FROM ---------------------------
# http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
##-ANSI-COLOR-CODES-##
Color_Off="\[\033[0m\]"
###-Regular-###
Red="\[\033[0;31m\]"
Green="\[\033[0;32m\]"
Purple="\[\033[0;35\]"
Yellow="\[\033[0;33m\]"
####-Bold-####
BRed="\[\033[1;31m\]"
BPurple="\[\033[1;35m\]"


# For when using chromeOS + crouton
file="/etc/debian_chroot"
codename=$(cat "$file")

# set up command prompt
function __prompt_command()
{
    # capture the exit status of the last command
    EXIT="$?"
    PS1=""
 
    # if [ $EXIT -eq 0 ]; then PS1+="\[$Green\][\!]\[$Color_Off\] "; else PS1+="\[$Red\][\!]\[$Color_Off\] "; fi
    # codename located in /etc/crouton/name but also from using lsb_release -c
    PS1+="\[$Green\][$codename]\[$Color_Off\] "
 
    # basic information (user@host:path)
    PS1+="\[$BRed\]\u\[$Color_Off\]@\[$BRed\]\h\[$Color_Off\]:\[$BPurple\]\w\[$Color_Off\] "
 
    # check if inside git repo
    # Display the branch name of git repository
    # Green -> clean
    # purple -> untracked files
    # red -> files to commit
    local git_status="`git status -unormal 2>&1`"    
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        # parse the porcelain output of git status
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$Purple
        else
            local Color_On=$Red
        fi
 
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
 
        # add the result to prompt
        PS1+="\[$Color_On\][$branch]\[$Color_Off\] "
    fi
 
    # If there's an active virtualenv, show it in brackets
    if [[ $VIRTUAL_ENV ]]; then
        PS1+="\[$Yellow\](`basename \"$VIRTUAL_ENV\"`)\[$Color_Off\] "
    fi
    
    # prompt $ or # for root
    PS1+="\$ "
}
PROMPT_COMMAND=__prompt_command
