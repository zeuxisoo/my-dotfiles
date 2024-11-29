#!/usr/bin/env bash

HOME_PATH=$HOME
CURRENT_PATH=$PWD
# CONFIG_DIRS=(git screen vim zed zsh)
CONFIG_DIRS=(git screen vim)

ERROR_STATUS=0

function install {
    for d in ${CONFIG_DIRS[*]}; do
        config_path="$CURRENT_PATH/$d"
        config_main="$config_path/main.sh"

        echo "[Install] $d ..."
        echo "> $config_main"
        bash $config_main install
    done
}

function uninstall {
    for d in ${CONFIG_DIRS[*]}; do
        config_path="$CURRENT_PATH/$d"
        config_main="$config_path/main.sh"

        echo "[Uninstall] $d ..."
        bash $config_main uninstall
    done
}

function usage {
    echo -e "Link dotfiles"
    echo -e "Usage $0 COMMAND..."
    echo -e "\nCommands:"

    echo -e "\t link"
    echo -e "\t unlink"

    exit 1
}

# Main Program
COMMAND=${@:$OPTIND:1}

case $COMMAND in
    install)
        install
    ;;

    uninstall)
        uninstall
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
