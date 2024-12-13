source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/alldir.sh

# Set install directory path
INSTALLER_PATH=$CURRENT_PATH/zsh

# Set self linked directory path and files, directory
CONFIG_PATH=$HOME_PATH/.config/zsh

function install {
    link
}

function uninstall {
    unlink
}

source $PWD/_utils/commands.sh
