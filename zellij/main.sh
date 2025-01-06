source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/alldir.sh

# set install directory path
INSTALLER_PATH=$CURRENT_PATH/zellij

# set self linked directory path and files, directory
CONFIG_PATH=$HOME_PATH/.config/zellij

function install {
    mkdir -p $CONFIG_PATH/plugins

    curl -L "https://github.com/imsnif/monocle/releases/latest/download/monocle.wasm" \
        -o ~/.config/zellij/plugins/monocle.wasm
    curl -L "https://github.com/rvcas/room/releases/latest/download/room.wasm" \
        -o ~/.config/zellij/plugins/room.wasm

    link
}

function uninstall {
    rm -rf $CONFIG_PATH/plugins
    unlink
}

source $PWD/_utils/commands.sh
