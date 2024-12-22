source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/dotfile.sh

# Set install directory path
INSTALLER_PATH=$CURRENT_PATH/vim

# Set self linked directory path
CONFIG_PATH=$HOME_PATH/.config/vim

function install {
    mkdir -p $CONFIG_PATH
    link
}

function uninstall {
    unlink
    rm -rf $CONFIG_PATH
}

source $PWD/_utils/commands.sh
