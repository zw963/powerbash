#!/usr/bin/env bash

# ps1 definition.

# \a : an ASCII bell character (07)
# \d : the date in "Weekday Month Date" format (e.g., "Tue May 26")
# \D{format} : the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required
# \e : an ASCII escape character (033)
# \h : the hostname up to the first '.'
# \H : the hostname
# \j : the number of jobs currently managed by the shell
# \l : the basename of the shell’s terminal device name
# \n : newline
# \r : carriage return
# \s : the name of the shell, the basename of $0 (the portion following the final slash)
# \t : the current time in 24-hour HH:MM:SS format
# \T : the current time in 12-hour HH:MM:SS format
# \@ : the current time in 12-hour am/pm format
# \A : the current time in 24-hour HH:MM format
# \u : the username of the current user
# \v : the version of bash (e.g., 2.00)
# \V : the release of bash, version + patch level (e.g., 2.00.0)
# \w : the current working directory, with $HOME abbreviated with a tilde
# \W : the basename of the current working directory, with $HOME abbreviated with a tilde
# \! : the history number of this command
# \# : the command number of this command
# \$ : if the effective UID is 0, a #, otherwise a $
# \nnn : the character corresponding to the octal number nnn
# \\ : a backslash
# \[ : begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
# \] : end a sequence of non-printing characters

# tput 方式使用编码

# 0 – Black
# 1 – Red
# 2 – Green
# 3 – Brown
# 4 – Blue
# 5 – Magenta
# 6 – Cyan
# 7 – White

# tput setab [1-7] – Set a background color using ANSI escape
# tput setb [1-7] – Set a background color
# tput setaf [1-7] – Set a foreground color using ANSI escape
# tput setf [1-7] – Set a foreground color

# tput bold – Set bold mode
# tput dim – turn on half-bright mode
# tput smul – begin underline mode
# tput rmul – exit underline mode
# tput rev – Turn on reverse mode
# tput smso – Enter standout mode (bold on rxvt)
# tput rmso – Exit standout mode
# tput sgr0 – Turn off all attributes

# if [ "$rvm_version" ]; then
#     PS1='
# \[$(tput setab 7)$(tput setaf 0)\]  ⚡  \[$(tput sgr0)\]\
    # \[$(tput setab ⮀)$(tput bold)$(tput setaf 4)\] \w\[$(tput sgr0)\]\
    # \[$(tput setaf 2)\]$(__git_ps1 " ➜ (%s)")\[$(tput sgr0)\]\
    # \[$(tput setaf 1)\]$(git rev-parse --is-inside-work-tree &>/dev/null && git log -1 --pretty="<%h>")\[$(tput sgr0)\] \
    # \[$(tput setaf 3)\][gemset:($(rvm-prompt))]\[$(tput sgr0)\]\
    # \[$(tput setaf 7)\][\[$(tput sgr0)\]\
    # \[$(tput setaf 7)\]\u@\h\[$(tput sgr0)\]\
    # \[$(tput setaf 6)\] $(date +"%m/%d %a %H:%M")\[$(tput sgr0)\]\
    # \[$(tput setaf 7)\]]\[$(tput sgr0)\]
# \[$(tput bold)$(tput setaf 7)\] ☠ \[$(tput sgr0)\]\
    # \$ '
# else
#     PS1='
# \[$(tput setab 7)$(tput setaf 0)\]  ⚡  \[$(tput sgr0)\]\
    # \[$(tput bold)$(tput setaf 4)\] \w\[$(tput sgr0)\]\
    # \[$(tput setaf 2)\]$(__git_ps1 " ➜ (%s)")\[$(tput sgr0)\] \
    # \[$(tput setaf 2)\]$(git rev-parse --is-inside-work-tree &>/dev/null && git log -1 --pretty="<%h>")\[$(tput sgr0)\] \
    # \[$(tput setaf 7)\][\[$(tput sgr0)\]\
    # \[$(tput setaf 7)\]\u@\h\[$(tput sgr0)\]\
    # \[$(tput setaf 6)\] $(date +"%m/%d %a %H:%M")\[$(tput sgr0)\]\
    # \[$(tput setaf 7)\]]\[$(tput sgr0)\]
# \[$(tput bold)$(tput setaf 7)\] ☠ \[$(tput sgr0)\]\
    # \$ '
# fi

# exit for non-interactive
[[ -z $PS1 ]] && return

BASH_START=$(echo -e '\001')
BASH_END=$(echo -e '\002')

DIM="${BASH_START}$(tput dim)${BASH_END}"
REVERSE="${BASH_START}$(tput rev)${BASH_END}"
RESET="${BASH_START}$(tput sgr0)${BASH_END}"
BOLD="${BASH_START}$(tput bold)${BASH_END}"

BLACK="${BASH_START}$(tput setaf 0)${BASH_END}"
RED="${BASH_START}$(tput setaf 1)${BASH_END}"
GREEN="${BASH_START}$(tput setaf 2)${BASH_END}"
BROWN="${BASH_START}$(tput setaf 3)${BASH_END}"
BLUE="${BASH_START}$(tput setaf 4)${BASH_END}"
MAGENTA="${BASH_START}$(tput setaf 5)${BASH_END}"
CYAN="${BASH_START}$(tput setaf 6)${BASH_END}"
WHITE="${BASH_START}$(tput setaf 7)${BASH_END}"

BG_BLACK="${BASH_START}$(tput setab 0)${BASH_END}"
BG_RED="${BASH_START}$(tput setab 1)${BASH_END}"
BG_GREEN="${BASH_START}$(tput setab 2)${BASH_END}"
BG_BROWN="${BASH_START}$(tput setab 3)${BASH_END}"
BG_BLUE="${BASH_START}$(tput setab 4)${BASH_END}"
BG_MAGENTA="${BASH_START}$(tput setab 5)${BASH_END}"
BG_CYAN="${BASH_START}$(tput setab 6)${BASH_END}"
BG_WHITE="${BASH_START}$(tput setab 7)${BASH_END}"

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

function __asdf () {
    local pattern="^$1"

    asdf current |awk "/$pattern/ {printf \$1\" \"\$2}"
}

__powerbash() {
    # define variables
    # POWERBASH_ICONS=( "⚑" "»" "♆" "☀" "♞" "☯" "☢" "❄" "+" "▶" "☠" "➦" "⮀" "⚡" "╭─" "╰─")
    # POWERBASH_ARROWS=( "⇠" "⇡" "⇢" "⇣" )

    function fg_color () {
        case "$1" in
            black) echo $BLACK;;
            red) echo $RED;;
            green) echo $GREEN;;
            yellow) echo $YELLOW;;
            blue) echo $BLUE;;
            magenta) echo $MAGENTA;;
            cyan) echo $CYAN;;
            white) echo $WHITE;;
        esac
    }

    function bg_color () {
        case "$1" in
            black) echo $BG_BLACK;;
            red) echo $BG_RED;;
            green) echo $BG_GREEN;;
            yellow) echo $BG_YELLOW;;
            blue) echo $BG_BLUE;;
            magenta) echo $BG_MAGENTA;;
            cyan) echo $BG_CYAN;;
            white) echo $BG_WHITE;;
        esac;
    }

    # Begin a segment
    # Takes two arguments, background and foreground. Both can be omitted,
    # rendering default background/foreground.
    function prompt_segment () {
        local background=$1
        local foreground=$2
        declare -a codes

        [[ -z $background || ( -z $foreground && $foreground != default ) ]] && codes+=($RESET)
        [[ -n $background ]] && codes+=($(bg_color $background))
        [[ -n $foreground ]] && codes+=($(fg_color $foreground))

        if [[ $CURRENT_BG != NONE && $background != $CURRENT_BG ]]; then
            echo -n "$(fg_color $CURRENT_BG)$(bg_color $background)$SEGMENT_SEPARATOR${codes[*]}"
        else
            echo -n "${codes[*]}"
        fi
        CURRENT_BG=$background
        [[ -n $3 ]] && echo -n "$3"
    }

    # End the prompt, closing any open segments
    function prompt_end () {
        if [[ -n $CURRENT_BG ]]; then
            echo -n " $RESET$(fg_color $CURRENT_BG)$SEGMENT_SEPARATOR"
        fi
        echo -n $RESET
        CURRENT_BG=''
    }

    __powerbash_colors() {
        if (( $(tput colors) < 256 )); then
            # 8 color support
            COLOR_DATE=$WHITE
            COLOR_USER=$BLACK$BG_WHITE
            COLOR_SUDO=$BROWN$BG_BLUE
            COLOR_SSH=$BOLD$RED$BG_WHITE
            COLOR_DIR=$WHITE$BG_BLUE
            COLOR_GIT=$WHITE$BG_CYAN
            COLOR_RVM=$BOLD$GREEN
            COLOR_ASDF=$BOLD$GREEN
            COLOR_RC=$WHITE$BG_RED
            COLOR_JOBS=$WHITE$BG_MAGENTA
            COLOR_SYMBOL_USER=$WHITE$BG_GREEN
            COLOR_SYMBOL_ROOT=$WHITE$BG_RED
        else
            # 256 color support
            COLOR_USER="${BASH_START}$(tput setaf 15)${BASH_END}${BASH_START}$(tput setab 8)${BASH_END}"
            COLOR_SUDO="$BROWN${BASH_START}$(tput setab 8)${BASH_END}"
            COLOR_SSH="$BROWN${BASH_START}$(tput setab 8)${BASH_END}"
            COLOR_DIR="$WHITE${BASH_START}$(tput setab 8)${BASH_END}"
            COLOR_GIT="${BASH_START}$(tput setaf 15)${BASH_END}$BG_BLUE"
            COLOR_RC="${BASH_START}$(tput setaf 15)${BASH_END}${BASH_START}$(tput setab 9)${BASH_END}"
            COLOR_JOBS="${BASH_START}$(tput setaf 15)${BASH_END}$BG_MAGENTA"
            COLOR_PY_VIRTUALENV="${BASH_START}$(tput setaf 15)${BASH_END}$BG_MAGENTA"
            COLOR_SYMBOL_USER="${BASH_START}$(tput setaf 15)${BASH_END}$BG_GREEN"
            COLOR_SYMBOL_ROOT="${BASH_START}$(tput setaf 15)${BASH_END}$BG_RED"
        fi
    }

    __powerbash_py_virtualenv_display() {
        [ -z "$POWERBASH_PY_VIRTUALENV" ] && POWERBASH_PY_VIRTUALENV="on" # sane default
        [ "$POWERBASH_PY_VIRTUALENV" == "off" ] && return # disable display
        [ -n "$VIRTUAL_ENV" ] || return # virtualenvironment not found

        # get virtualenv name
        local venv="$(basename $VIRTUAL_ENV)"
        [ -n "$venv" ] || return

        printf "$COLOR_PY_VIRTUALENV ▶ $venv $RESET"
    }

    __powerbash_git_display() {
        which git &>/dev/null || return # git not found
        [ -z "$POWERBASH_GIT" ] && POWERBASH_GIT="on" # sane default
        [ "$POWERBASH_GIT" == "off" ] && return # disable display

        if git rev-parse --is-inside-work-tree &>/dev/null; then
            local GIT_PS1_SHOWDIRTYSTATE=true
            local GIT_PS1_SHOWSTASHSTATE=true
            local GIT_PS1_SHOWUNTRACKEDFILES=true
            local GIT_PS1_SHOWUPSTREAM="verbose"
            __git_ps1 "$MAGENTA ⭠ $(git log -1 --pretty="(%h)") %s $RESET"
        fi
    }

    __powerbash_rvm_display() {
        which rvm-prompt &>/dev/null || return # rvm not installed
        [ -n "$(rvm-prompt)" ] || return # current no rvm gemset
        [ -z "$POWERBASH_RVM" ] && POWERBASH_RVM="on" # sane default
        [ "$POWERBASH_RVM" == "off" ] && return # disable display
        [[ -n "$rvm_version" ]] || return # rvm not loaded.

        [ "$POWERBASH_RVM" == "on" ] && printf " $COLOR_RVM➦ $(rvm-prompt) $RESET"
    }

    __powerbash_asdf_display() {
        which asdf &>/dev/null || return # asdf not installed
        [ -z "$POWERBASH_ASDF" ] && POWERBASH_ASDF="on" # sane default
        [ "$POWERBASH_ASDF" == "off" ] && return # disable display

        asdf_output=$(asdf current)
        [ "$POWERBASH_ASDF_CRYSTAL" == off ] && asdf_output=$(echo "$asdf_output" |grep -v '^crystal')
        [ "$POWERBASH_ASDF_ELIXIR" == off ] && asdf_output=$(echo "$asdf_output" |grep -v '^elixir')
        [ "$POWERBASH_ASDF_ELIXIR_LS" == off ] && asdf_output=$(echo "$asdf_output" |grep -v '^elixir-ls')


        if [ "$POWERBASH_ASDF" == "on" ]; then
            echo "$asdf_output" |awk "{printf \"$COLOR_ASDF➦ \" \$1\" \"\$2\" \"}"
        fi
    }

    __powerbash_date_display() {
        [ -z "$POWERBASH_DATE" ] && POWERBASH_DATE="on" # sane default
        [ "$POWERBASH_DATE" == "off" ] && return # disable display
        [ -n "$SUDO_USER" ] && COLOR_USER="$COLOR_SUDO"
        [ "$POWERBASH_DATE" == "on" ] && printf "\n$COLOR_DATE ╭─ $(date +"%H:%M") $RESET"
    }

    __powerbash_user_display() {
        [ -z "$POWERBASH_USER" ] && POWERBASH_USER="on" # sane default
        [ "$POWERBASH_USER" == "off" ] && return # disable display
        [ -n "$SUDO_USER" ] && COLOR_USER="$COLOR_SUDO"
        [ "$POWERBASH_USER" == "on" ] && prompt_segment white black "\u"
    }

    __powerbash_host_display() {
        [ -z "$POWERBASH_HOST" ] && POWERBASH_HOST="auto" # sane default
        [ "$POWERBASH_HOST" == "off" ] && return # disable display
        [ "$POWERBASH_HOST" == "auto" ] && [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]] && POWERBASH_HOST=on
        [ "$POWERBASH_HOST" == "on" ] && printf "$COLOR_SSH@\\h$RESET"
    }

    __powerbash_path_parted() {
        local dir_split_count=5
        local pwd=${PWD/$HOME/'~'}
        local dir_parted=$pwd
        local dir_array=""

        if [ $pwd == $HOME ]; then
            dir_array=('~')
        else
            IFS='/' read -a dir_array <<< "$pwd"
        fi

        if [ ${#dir_array[@]} -gt $dir_split_count ]; then
            local dir_parted="${dir_array[0]}/${dir_array[1]}/.../${dir_array[${#dir_array[@]}-2]}/${dir_array[${#dir_array[@]}-1]}"
        fi

        printf "$dir_parted"
    }

    __powerbash_path_short() {
        [ -z "$POWERBASH_PATH_SHORT_LENGTH" ] && POWERBASH_PATH_SHORT_LENGTH=20 # sane default

        local short_path=$PWD
        (( ${#PWD} > $POWERBASH_PATH_SHORT_LENGTH )) && short_path="..${PWD: -$POWERBASH_PATH_SHORT_LENGTH}"

        printf "$short_path"
    }

    __powerbash_path_short_length() {
        [ -z "$POWERBASH_PATH_SHORT_LENGTH" ] && POWERBASH_PATH_SHORT_LENGTH=20 # sane default

        [ -n $2 ] && local length="$2" # add/subtract by $2 when provided
        [ -z "$length" ] && local length="1" # add/subtract by 1 by default
        [ "$1" == "subtract" ] && ((POWERBASH_PATH_SHORT_LENGTH-=$length))
        [ "$1" == "add" ] && ((POWERBASH_PATH_SHORT_LENGTH+=$length))

        return 0
    }

    __powerbash_path_mini() {
        local current_path="${PWD/$HOME/\~}"

        IFS='/' read -a dir_array <<< "$current_path"

        local path=""
        local dir_len=$((${#dir_array[@]}-1))

        for dir in ${dir_array[@]:0:$dir_len}; do
            [[ $dir == '~' ]] && path="${dir:0:1}" || path="$path/${dir:0:1}"
        done
        path="$path/${dir_array[$dir_len]}"

        printf "$path"
    }

    __powerbash_path_display() {
        [ -z "$POWERBASH_PATH" ] && POWERBASH_PATH="full" # sane default
        [ "$POWERBASH_PATH" == "off" ] && return # disable display

        local dir_display=""
        case "$POWERBASH_PATH" in
            full) dir_display="\\w" ;;
            working) dir_display="\\W" ;;
            parted) dir_display="$(__powerbash_path_parted)" ;;
        esac

        prompt_segment white black ""
        prompt_segment black white "$dir_display"
        prompt_end
    }

    __powerbash_jobs_display() {
        [ -z "$POWERBASH_JOBS" ] && POWERBASH_JOBS="on" # sane default
        [ "$POWERBASH_JOBS" == "off" ] && return # disable display
        [ $(jobs | wc -l) -ne "0" ] && printf "$COLOR_JOBS \\j $RESET"
    }

    __powerbash_symbol_display() {
        [ -z "$POWERBASH_SYMBOL" ] && POWERBASH_SYMBOL="on" # sane default
        [ "$POWERBASH_SYMBOL" == "off" ] && return # disable display

        # different color for root and regular user
        local symbol_bg=$COLOR_SYMBOL_USER
        [ $EUID -eq 0 ] && symbol_bg=$COLOR_SYMBOL_ROOT

        printf "\n ╰──➤ \\$""$RESET"
    }

    __powerbash_rc_display() {
        [ -z "$POWERBASH_RC" ] && POWERBASH_RC="on" # sane default
        [ "$POWERBASH_RC" == "off" ] && return # disable display
        [ $1 -ne 0 ] && printf "$COLOR_RC $1 $RESET"
    }

    __powerbash_ps1() {
        # keep this at top!!!
        # capture latest return code
        local RETURN_CODE=$?

        case "$1" in
            off)    PS1='\$ ' ;;
            system) PS1=$POWERBASH_SYSTEM_PS1 ;;
            on)
                # check for supported colors
                __powerbash_colors

                # set prompt
                PS1=""
                PS1+="$(__powerbash_py_virtualenv_display)"
                PS1+="$(__powerbash_date_display)"
                PS1+="$(__powerbash_user_display)"
                PS1+="$(__powerbash_host_display)"
                PS1+="$(__powerbash_path_display)"
                PS1+="$(__powerbash_git_display)"
                PS1+="$(__powerbash_rvm_display)"
                PS1+="$(__powerbash_asdf_display)"
                PS1+="$(__powerbash_jobs_display)"
                PS1+="$(__powerbash_symbol_display)"
                PS1+="$(__powerbash_rc_display ${RETURN_CODE})"
                PS1+=" "
                ;;
        esac
    }

    PROMPT_COMMAND="__powerbash_ps1 on"
}

# save system PS1
[[ -z "$POWERBASH_SYSTEM_PS1" ]] && POWERBASH_SYSTEM_PS1=$PS1

# start powerbash
__powerbash
unset __powerbash
