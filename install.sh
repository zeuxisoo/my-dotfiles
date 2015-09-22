#!/usr/bin/env bash

ERROR_STATUS=0

function link {
    for dotfile in `ls -d .??* | grep -vE '.DS_Store|.git$'`; do
        echo "Link from $PWD/$dotfile"
        rm -rf $HOME/$dotfile
        ln -s $PWD/$dotfile $HOME/$dotfile
    done
}

function unlink {
    for dotfile in `ls -d .??* | grep -vE '.DS_Store|.git$'`; do
        echo "rm -rf $HOME/$dotfile"
        rm -rf $HOME/$dotfile
    done
}

function install_zsh_plugin {
    # password generator
    if [ -d ~/.oh-my-zsh/custom/plugins/password_generator ]; then
        rm -rf ~/.oh-my-zsh/custom/plugins/password_generator
    fi

    mkdir -p ~/.oh-my-zsh/custom/plugins/password_generator
    git clone git://github.com/Xiphe/Password-Generator-for-zsh.git ~/.oh-my-zsh/custom/plugins/password_generator

    new_line

    # Fish-like autosuggestions
    if [ -d ~/.oh-my-zsh/custom/plugins/autosuggestions ]; then
        rm -rf ~/.oh-my-zsh/custom/plugins/autosuggestions
    fi

    mkdir -p ~/.oh-my-zsh/custom/plugins/autosuggestions
    git clone git://github.com/tarruda/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/autosuggestions

    bash ~/.oh-my-zsh/custom/plugins/autosuggestions/install

    new_line

    # Vim Vundle with vim >= 7.4
    brew install vim

    if [ -d ~/.vim/bundle/Vundle.vim]; then
        rm -rf ~/.vim/bundle/Vundle.vim
    fi

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    new_line
}

function usage {
    echo -e "Link all dotfiles"
    echo -e "Usage $0 COMMAND..."
    echo -e "\nCommands:"

    echo -e "\t link"
    echo -e "\t unlink"

    exit 1
}

function print {
    if [[ $QUIET == 0 ]]; then
        echo -ne "$1";
    fi
}

function new_line {
    echo ""
}

# Main Program
COMMAND=${@:$OPTIND:1}

case $COMMAND in

    link)
        install_zsh_plugin
        link
    ;;

    unlink)
        unlink
    ;;

    *)
        if [[ COMMAND != "" ]]; then
            print "Error: unknown command > $COMMAND\n\n"
            ERROR_STATUS=1
        fi

        usage
    ;;
esac

exit $ERROR_STATUS
