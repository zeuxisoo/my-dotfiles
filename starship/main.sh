source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
source $PWD/_utils/linkers/filelist.sh

# set install directory path
INSTALLER_PATH=$CURRENT_PATH/starship

# set self linked directory path and files
CONFIG_PATH=$HOME_PATH/.config/starship
LINK_FILES=(
    "starship.toml"
)

function install {
    link
}

function uninstall {
    unlink
}

source $PWD/_utils/commands.sh
