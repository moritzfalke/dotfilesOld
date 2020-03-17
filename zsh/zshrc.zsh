# create or attach to main tmux session
if [ "$TMUX" = "" ]; then tmux new-session -A -s main; fi

# Vars
    export TERM="xterm-256color"
    export ZSH=$HOME/.oh-my-zsh
    export VISUAL=vim
    export EDITOR=vim
    # get directory of this script
    # https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
    SOURCE=${(%):-%N}
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    DOTFILES_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# tried powerlevel9k
#export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh context dir rbenv vcs)
#export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs public_ip)
#export ZSH_THEME="powerlevel9k/powerlevel9k"

# Oh-my-zsh
    # Plugins
    plugins=(
        git
        vi-mode
        common-aliases
        zsh-syntax-highlighting
        zsh-autosuggestions
        z
    )

    source $ZSH/oh-my-zsh.sh

# Aliases

    #nvim
    alias vimdiff='nvim -d'
    #alias vim='nvim'
    function open_vim() {
        if [ "$1" != "" ] ; then
            nvim $1
        else
            nvim .
        fi
    }
    alias vim="open_vim"

    # Sudo
    alias _='sudo'

    # Custom cd
    c() {
        cd $1;
        ls;
    }
    alias cd="c"

    # Switch to newly created directory
    mdir() {
        mkdir $1;
        cd $1;
    }
    alias mkdir="mdir"
#if ![[ $(uname -a) == "*Darwin*" ]] ; then
#    eval $(dircolors $DOTFILES_DIR/nord_dircolors)
#fi
source $DOTFILES_DIR/prompt.zsh

# fix problems with background jobs on windows for zsh
# https://github.com/rupa/z/issues/230
case $(uname -a) in
   *Microsoft*) unsetopt BG_NICE ;;
esac
