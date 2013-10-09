#!/usr/bin/env bash

ERROR_STATUS=0

function link {
    for dotfile in `ls -d .??* | grep -vE '.DS_Store'`; do
        echo "Link from $PWD/$dotfile"
        rm -rf $HOME/$dotfile
        ln -s $PWD/$dotfile $HOME/$dotfile
    done
}

function unlink {
    for dotfile in `ls -d .??* | grep -vE '.DS_Store'`; do
        echo "rm -rf $HOME/$dotfile"
        rm -rf $HOME/$dotfile
    done
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

# Main Program
COMMAND=${@:$OPTIND:1}

case $COMMAND in

    link)
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
