#!/bin/bash
#
# install things

DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
set -e

# functions from https://github.com/Parth/dotfiles
check_for_software() {
    echo "Checking to see if $1 is installed"
    if ! [ -x "$(command -v $1)" ]; then
        if [ $1 == "nvim" ]; then
            install neovim
        else
            install $1
        fi
    else
        echo "$1 is installed."
    fi
}

install() {
    read -p "$1 is not installed. Would you like to install it? [Y|n]" -n 1 -e YN
    if [[ $YN == "y" || $YN == "Y" || $YN == "" ]]; then
        if [ -x "$(command -v apt-get)" ]; then
            # Add repository for neovim on Ubuntu
            if [[ "$1" == "neovim" && -x "$(command -v lsb_release)" && "$(lsb_release -i)" == *"Ubuntu"* ]] ; then
                echo "adding repository for neovim"
                sudo apt-get install software-properties-common
                sudo add-apt-repository ppa:neovim-ppa/stable
                sudo apt-get update
            fi
            sudo apt-get install $1 -y
        elif [ -x "$(command -v brew)" ]; then
            brew install $1
        elif [ -x "$(command -v pkg)" ]; then
            sudo pkg install $1
        elif [ -x "$(command -v pacman)" ]; then
            sudo pacman -S $1
        else
            echo "I'm not sure what your package manager is! Please install $1 on your own and run this deploy script again. Tests for package managers are in the deploy script you just ran starting at line 13. Feel free to make a pull request at https://github.com/parth/dotfiles :)"
        fi
    else
        echo "Cancelled installation of $1"
    fi
}

check_for_software curl
echo
check_for_software git
echo
check_for_software zsh
echo
check_for_software tmux
echo
check_for_software nvim
echo
if [ -d ~/.oh-my-zsh/]; then
    echo -e "installing oh-my-zsh"
    echo "When installed, run 'exit' to continue the installation of the dotfiles"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

read -p "Do you want to backup your old config files to *.old? [Y|n]" -n 1 -e YN
if [[ $YN == "y" || $YN == "Y" || $YN == "" ]]; then
    [ -f ~/.vimrc ] && mv -i ~/.vimrc ~/.vimrc.old
    [ -f ~/.tmux.conf ] && mv -i ~/.tmux.conf ~/.tmux.conf.old
    [ -f  ~/.config/nvim/init.vim ] && mv -i ~/.config/nvim/init.vim ~/.config/nvim/init.vim.old
fi

echo 'Creating symlinks to the config files'
ln -nsf $DOTFILES_ROOT/vim/vimrc.vim ~/.vimrc
ln -nsf $DOTFILES_ROOT/tmux/tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim
ln -nsf $DOTFILES_ROOT/vim/init.vim ~/.config/nvim/init.vim
ln -nsf $DOTFILES_ROOT/zsh/zshrc.zsh ~/.zshrc
ln -nsf $DOTFILES_ROOT/tmux/tmux.remote.conf ~/.tmux.remote.conf

# Installing oh-my-zsh plugins
if ! [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ] ; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
if ! [ -d  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ] ; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Installing tpm, the plugin manager for tmux
if ! [ -d ~/.tmux/plugins/tpm ] ; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo -e "\n\n\n\t Everything installed! please do the following steps now: \n"
echo "Please press <tmux prefix>+I to download all necessary plugins"
echo "The neovim Plugins will automatically be downloaded on the next start of neovim"
echo "Please restart your shell now"
