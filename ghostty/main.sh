source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/filelist.sh

# Set install directory path
INSTALLER_PATH=$CURRENT_PATH/ghostty

# Set self linked directory path and files
CONFIG_PATH=$HOME_PATH/.ghostty/zed
LINK_FILES=(
    "config"
)

function install {
    link
}

function uninstall {
    unlink
}

source $PWD/_utils/commands.sh
