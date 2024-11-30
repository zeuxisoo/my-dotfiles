source $PWD/_utils/variables.sh
source $PWD/_utils/functions.sh
# source $PWD/_utils/linkers/dotfile.sh

# Set install directory path
INSTALLER_PATH=$CURRENT_PATH/zed

# Set self linked directory path and files
CONFIG_PATH=$HOME_PATH/.config/zed
LINK_FILES=(
    "keymap.json"
    "settings.json"
)

function install {
    mkdir -p $CONFIG_PATH

    for link_file in ${LINK_FILES[*]}; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Link from $config_file_path"

        rm -rf $CONFIG_PATH/$link_file
        ln -s $config_file_path $CONFIG_PATH/$link_file
    done
}

function uninstall {
    for link_file in ${LINK_FILES[*]}; do
        config_file_path=$INSTALLER_PATH/$link_file

        echo "Unlink from $config_file_path"

        rm -rf $CONFIG_PATH/$link_file
    done
}

source $PWD/_utils/commands.sh
