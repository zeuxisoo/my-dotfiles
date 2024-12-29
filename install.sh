#!/usr/bin/env bash

HOME_PATH=$HOME
CURRENT_PATH=$PWD
CONFIG_DIRS=(ghostty git screen starship vim wezterm zed)

error_status=0

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

    echo -e "\t install"
    echo -e "\t uninstall"

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
            echo "Error: unknown command > $COMMAND"
            error_status=1
        fi

        usage
    ;;
esac

exit $error_status
