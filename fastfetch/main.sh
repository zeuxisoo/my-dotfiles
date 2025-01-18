source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/alldir.sh

# set install directory path
INSTALLER_PATH=$CURRENT_PATH/fastfetch

# set self linked directory path and files, directory
CONFIG_PATH=$HOME_PATH/.config/fastfetch

function install {
    link
}

function uninstall {
    unlink
}

source $PWD/_utils/commands.sh
