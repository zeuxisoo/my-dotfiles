source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/filelist.sh

# set install directory path
INSTALLER_PATH=$CURRENT_PATH/ghostty

# set self linked directory path and files
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
